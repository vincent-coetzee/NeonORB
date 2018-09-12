//
//  ORB.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/27.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation
import Socket
import LoggerAPI

public class NeonORB:ORB,CORBA_ORB
    {
    public static var shared:ORB!
    
    private var primarySocket:Socket!
    public let queue:DispatchQueue
    private var namingServiceServerSocket:Socket!
    
    public let port:Int
    public var host:String
    
    private var registeredBOAs:[String:BasicObjectAdaptor] = [:]
    private var registeredImplementations:[String:Implementation] = [:]
    private var rootContextImplementation:CosNaming_NamingContext_Implementation!
    private var rootContextReference:CosNaming_NamingContext!
    private var remoteRootContextFound = false
    
    public var namingService:CosNaming_NamingContext = CosNaming_NamingContext_Interface(host:"",port:0,objectId:"",interfaceId:InterfaceId(""))
    
    private var socketPool = SocketPool()
    
    public init() throws
        {
        Log.verbose("Neon ORB Version \(Neon.kVersion)")
        let (address,_) = IPV4Address.ethernetAddresses()[0]
        self.host = address.string
        port = Int.random(in: 10240..<65534)
        Log.verbose("Init ORB")
        queue = DispatchQueue(label:"com.macsemantics.coral.orb",attributes: .concurrent)
        primarySocket = try Socket.create(family: .inet, type: .stream, proto: .tcp)
        Log.verbose("Created primary socket")
        try primarySocket.listen(on: port)
        namingServiceServerSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
        Log.verbose("Created naming service socket")
        CORBA.orb = self
        try searchForNamingService()
        try initORBService()
        if !remoteRootContextFound
            {
            try initNamingService()
            }
        }
    
    private func initORBService() throws
        {
        Log.verbose("Init ORB service on port \(port)")
        Log.verbose("Starting primary ORB service loop")
        let (address,_) = IPV4Address.ethernetAddresses()[0]
        self.host = address.string
        queue.async
            {
            while true
                {
                do
                    {
                    let clientSocket = try self.primarySocket.acceptClientConnection(invokeDelegate: false)
                    Log.verbose("Incoming connection request")
                    self.queue.async
                        {
                        self.service(clientConnection:clientSocket)
                        }
                    }
                catch
                    {
                    }
                }
            }
        }
    
    private func resetEntities()
        {
        registeredBOAs = [:]
        registeredImplementations = [:]
        }
    
    public func materialize(object:CORBA_Object) -> Implementation?
        {
        let id = object.objectId
        let implementation = registeredImplementations[id]
        return(implementation)
        }
        
    private func service(clientConnection:Socket)
        {
        while true
            {
            do
                {
                var buffer = Data(capacity: Neon.kRequestBufferSizeInBytes)
                let bytesRead = try clientConnection.read(into: &buffer)
                if bytesRead > 0
                    {
                    var isEnd = false
                    let response = try self.processIncoming(data:buffer,isEnd:&isEnd)
                    try clientConnection.write(from: response)
                    if isEnd
                        {
                        clientConnection.close()
                        return
                        }
                    }
                }
            catch
                {
                Log.error("Unexpected error \(error) in service(clientConnection:)")
                }
            }
        }
    
    private func processIncoming(data:Data,isEnd:inout Bool) throws -> Data
        {
        let unmarshaller = IIOPUnmarshaller(bytes:data)
        let dataSize = unmarshaller.unmarshal(Int.self)
        guard dataSize == data.count else
            {
            throw(CORBA.ORBError.badRequestSize)
            }
        guard unmarshaller.unmarshal(Int32.self) == CORBA.kNeonMagicNumber else
            {
            throw(CORBA.ORBError.notNeonMessage)
            }
        let kind = unmarshaller.unmarshal(CORBA.MessageKind.self)
        switch(kind)
            {
            case .request:
                return(try processRequest(unmarshaller:unmarshaller))
            case .ping:
                return(IIOPBuffer.pongBytes)
            case .end:
                let response = Data(repeating: 0, count: 8)
                isEnd = true
                return(response)
            default:
                fatalError()
            }
        }
    
    private func processORBRequest(unmarshaller:IIOPUnmarshaller) throws -> Data
        {
        let operationId = unmarshaller.unmarshal(String.self)
        if operationId == "_create"
            {
            let interfaceId = unmarshaller.unmarshal(String.self)
            let boa = registeredBOAs[interfaceId]!
            let instance = boa.createInstance()
            let marshaller = IIOPMarshaller(bufferSize:Neon.kRequestBufferSizeInBytes)
            marshaller.marshal(CORBA.ResultKind.success)
            marshaller.marshal(instance)
            return(marshaller.bytes)
            }
        fatalError()
        }
    
    //
    // CORBA_ORB conformance
    //

    public var objectId:String
        {
        return("0000-0000-0000-0000")
        }
    
    public var interfaceId:InterfaceId
        {
        return("CORBA::ORB")
        }
    
    public func narrow<T:ObjectStub>(_ type:T.Type) throws -> T
        {
        throw(CORBA.ORBError.invalidTypes)
        }
    
    public func shutdown() throws
        {
        for implementation in registeredImplementations.values
            {
            implementation.deactivateObject()
            }
        }
    
    public func destroy(object:CORBA_Object?) throws
        {
        guard let object = object else
            {
            return
            }
        guard let realObject = registeredImplementations[object.objectId] else
            {
            throw(CORBA_ORB_NotFound())
            }
        registeredImplementations[object.objectId] = nil
        realObject.destroyObject()
        }
    
    public func create(interfaceId:String) throws -> CORBA_Object?
        {
        return(Implementation())
        }
        
    private func processRequest(unmarshaller:IIOPUnmarshaller) throws -> Data
        {
        let marshaller = IIOPMarshaller(bufferSize:Neon.kRequestBufferSizeInBytes)
        do
            {
            guard let object = unmarshaller.unmarshal(ObjectStub.self) else
                {
                throw(CORBA.ORBError.badObjectReference)
                }
            if object.objectId == Neon.kORBObjectId
                {
                return(try processORBRequest(unmarshaller:unmarshaller))
                }
            guard let boa = registeredBOAs[object.interfaceId.rawValue] else
                {
                throw(CORBA.ORBError.badObjectReference)
                }
            let operationId = unmarshaller.unmarshal(String.self)
            guard boa.respondsTo(operation:operationId) else
                {
                throw(CORBA.ORBError.badOperation)
                }
            guard let server = registeredImplementations[object.objectId] else
                {
                throw(CORBA.ORBError.badObjectReference)
                }
            marshaller.marshal(CORBA.MessageKind.response)
            try boa.invoke(operation:operationId,on:server,outof: unmarshaller,into: marshaller)
            Log.verbose("Request \(operationId) was successful")
            }
        catch let error where error is CORBA.ORBError
            {
            Log.verbose("Request failed with \(error)")
            marshaller.marshal(CORBA.ResultKind.systemException)
            marshaller.marshal(error as! CORBA.ORBError)
            }
        catch let error where error is CORBA.Exception
            {
            Log.verbose("Request failed with \(error)")
            marshaller.marshal(CORBA.ResultKind.corbaException)
            marshaller.marshal(error as! CORBA.Exception)
            }
        catch
            {
            Log.verbose("Request failed with \(error)")
            marshaller.marshal(CORBA.ResultKind.systemException)
            marshaller.marshal(CORBA.ORBError.unknown)
            Log.error("Error invoking operation")
            }
        return(marshaller.bytes)
        }
    
    public func deregisterImplementation(_ object: Implementation)
        {
        }
    
    private func searchForNamingService() throws
        {
        let waitBetweenTriesInSeconds:TimeInterval = 2
        guard let (address,mask) = IPV4Address.ethernetAddresses().first else
            {
            return
            }
        Log.verbose("Primary address is \(address.string)")
        let broadcastAddress = address.broadcastAddress(withNetmask: mask).string
        Log.verbose("Naming service broadcast address is \(broadcastAddress)")
        let socketAddress = Socket.createAddress(for: broadcastAddress, on: Int32(Neon.kDefaultNamingServicePortNumber))!
        let namingServiceSearchSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
        try namingServiceSearchSocket.udpBroadcast(enable: true)
        let request = IIOPMarshaller().requestBytes(for:"NamingService")
        var namingServiceNotFound = true
        var repeatCount = 0
        Log.verbose("Starting search for root context")
        while namingServiceNotFound && repeatCount < 10
            {
            try namingServiceSearchSocket.write(from: request, to: socketAddress)
            Log.verbose("Search broadcast sent, waiting for reply")
            var datagram = Data(capacity: 4096)
            try namingServiceSearchSocket.setReadTimeout(value: 2000)
            let (bytesRead,_) = try namingServiceSearchSocket.readDatagram(into: &datagram)
            if bytesRead > 0
                {
                Log.verbose("Received reply to root context request")
                let unmarshaller = IIOPUnmarshaller(bytes: datagram)
                let dataLength = unmarshaller.unmarshal(Int.self)
                if dataLength == bytesRead
                    {
                    let messageKind = unmarshaller.unmarshal(CORBA.MessageKind.self)
                    guard messageKind == .response else
                        {
                        throw(CORBA.ORBError.badMessage)
                        }
                    rootContextReference = unmarshaller.unmarshal(CosNaming_NamingContext.self)
                    namingService = rootContextReference
                    remoteRootContextFound = true
                    namingServiceNotFound = false
                    namingServiceSearchSocket.close()
                    Log.verbose("Successfully found root context for naming service")
                    return
                    }
                else
                    {
                    Log.error("Mismatch of bytesRead(\(bytesRead)) to dataLength(\(dataLength))")
                    }
                }
            else
                {
                Thread.sleep(forTimeInterval: waitBetweenTriesInSeconds)
                repeatCount += 1
                }
            }
        Log.verbose("Failed to find naming service after retries, will create one")
        }
    
    public func initNamingService() throws
        {
        Log.verbose("Remote naming service not found")
        Log.verbose("Init naming service")
        guard let (address,_) = IPV4Address.ethernetAddresses().first else
            {
            throw(CORBA.ORBError.ethernetAddressNotFound)
            }
        rootContextImplementation = CosNaming_NamingContext_Implementation.rootContext
        rootContextImplementation.port = port
        rootContextImplementation.host = address.string
        rootContextImplementation.objectId = "0000-0000-0000-1111"
        namingService = rootContextImplementation
        Log.verbose("Created root context")
        self.resetEntities()
        self.registerBOA(CosNaming_NamingContext_BOA.self, forInterfaceId: "CosNaming::NamingContext")
        self.registerImplementation(rootContextImplementation, forObjectId: rootContextImplementation.objectId)
        try namingServiceServerSocket.udpBroadcast(enable: true)
        queue.async
            {
            var data = Data(capacity:4096)
            while true
                {
                do
                    {
                    let (bytesRead,sourceAddress) = try self.namingServiceServerSocket.listen(forMessage: &data, on: Neon.kDefaultNamingServicePortNumber)
                    Log.verbose("Received request for naming service")
                    if bytesRead > 0
                        {
                        try self.processNamingServiceRequest(data:data,returnAddress:sourceAddress!)
                        }
                    }
                catch
                    {
                    Log.verbose("Error reading naming service socket \(error) - waiting 5 seconds")
                    Thread.sleep(forTimeInterval: 5)
                    }
                }
            }
        Log.verbose("Started naming service listener")
        }

    private func processNamingServiceRequest(data:Data,returnAddress:Socket.Address) throws
        {
        Log.verbose("Began processing naming service request")
        let buffer = IIOPMarshaller(bufferSize:4096)
        buffer.marshal(CORBA.MessageKind.response)
        buffer.marshal(rootContextImplementation)
        let bytes = buffer.bytes
        try namingServiceServerSocket.write(from: bytes, to: returnAddress)
        Log.verbose("Successfully processed naming service request")
        }
    
    public func BOA(atObjectId id:String) -> BasicObjectAdaptor?
        {
        return(registeredBOAs[id])
        }
        
    public func registerBOA(_ boa:BasicObjectAdaptor.Type,forInterfaceId id:String)
        {
        registeredBOAs[id] = boa.init()
        Log.verbose("Registered BOA\(boa) for \(id)")
        }
    
    public func registerImplementation(_ implementation:Implementation,forObjectId id:String)
        {
        implementation.host = self.host
        implementation.port = self.port
        registeredImplementations[id] = implementation
        Log.verbose("Registered \(implementation) for \(id)")
        }
    
    public func run()
        {
        while true
            {
            Thread.sleep(forTimeInterval: 5)
            }
            
        }
    }
