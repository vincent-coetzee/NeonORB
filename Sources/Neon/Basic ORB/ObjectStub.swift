//
//  ObjectProxy.swift
//  Jet
//
//  Created by Vincent Coetzee on 2018/08/28.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation
import Socket

open class ObjectStub:CORBA_Object,Equatable
    {
    public internal(set) var host:String = ""
    public internal(set) var port:Int = 0
    public internal(set) var objectId:String = UUID().uuidString
    public var orb:ORB = CORBA.orb
    public var interfaceId:InterfaceId
    
    open class func interfaceId() -> InterfaceId
        {
        return("CORBA::Object")
        }
    
    public class func null() -> Self
        {
        return(self.init(host:"",port:0,objectId:"",interfaceId:""))
        }
    
    public static func ==(lhs:ObjectStub,rhs:ObjectStub) -> Bool
        {
        guard lhs.host == rhs.host else 
            {
            return(false)
            }
        guard lhs.port == rhs.port else
            {
            return(false)
            }
        guard lhs.objectId == rhs.objectId else
            {
            return(false)
            }
        guard lhs.interfaceId == rhs.interfaceId else
            {
            return(false)
            }
        return(true)
        }
    
    public required init(host:String,port:Int,objectId:String,interfaceId:InterfaceId)
        {
        self.host = host
        self.port = port
        self.objectId = objectId
        self.interfaceId = interfaceId
        }
        
    public init(_ implementation:Implementation)
        {
        self.host = implementation.host
        self.port = implementation.port
        self.objectId = implementation.objectId
        self.orb = implementation.orb
        self.interfaceId = implementation.interfaceId
        }
    
    open func marshal(on marshaller:IIOPMarshaller) throws
        {
        marshaller.marshal(host)
        marshaller.marshal(port)
        marshaller.marshal(objectId)
        marshaller.marshal(interfaceId)
        }
    
    open func narrow<T:ObjectStub>(_ type:T.Type) throws -> T
        {
        let targetId = type.interfaceId()
        let thisId = self.interfaceId
        if targetId != thisId
            {
            throw(CORBA.ORBError.invalidTypes)
            }
        return(T(host:self.host,port:self.port,objectId:self.objectId,interfaceId:targetId))
        }
    
    open func invocation(forOperation operationId:String) -> Invocation
        {
        do
            {
            let host = self.host
            let port = self.port
            var poolSocket = SocketPool.shared.remove(forHost:host,onPort:port)
            if poolSocket == nil
                {
                poolSocket = try Socket.create(family: .inet, type: .stream, proto: .tcp)
                try poolSocket?.connect(to: host, port: Int32(port))
                }
            let invocation = Invocation(object: self,socket:poolSocket!)
            invocation.set(messageKind: .request,operationId:operationId)
            return(invocation)
            }
        catch
            {
            fatalError("\(error)")
            }
        }
    }

public typealias CORBAObject = ObjectStub
