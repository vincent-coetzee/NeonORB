//
//  RemoteORB.swift
//  Jet
//
//  Created by Vincent Coetzee on 2018/09/08.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public struct RemoteORB:ORB
    {
    private let _host:String
    private let _port:Int
    private let localORB:ORB
    
    init(host:String,port:Int,localORB:ORB)
        {
        _host = host
        _port = port
        self.localORB = localORB
        }
    
    public var queue:DispatchQueue
        {
        fatalError()
        }
    
    public var namingService:CosNaming_NamingContext
        {
        return(CosNaming_NamingContext_Implementation())
        }
    
    public var host:String
        {
        return(_host)
        }
    
    public var port:Int
        {
        return(_port)
        }
    
//    public func destroy(object:CORBA_Object) throws
//        {
////        let objectStub = ObjectStub(host: _hostname,port:_port,objectId:"0000-0000-0000-0000",interfaceId:"CORBA::ORB")
////        let invocation = try localORB.invocation(messageKind: .orbRequest,on:objectStub, operationId: "_destroy")
////        invocation.marshaller().marshal(object.objectId)
////        try invocation.invoke(expect:.orbResponse)
////        let resultKind = invocation.unmarshaller().unmarshal(CORBA.ResultKind.self)
////        }
//    
//    public func create<T>(_ type:T.Type) throws -> T where T:ObjectStub
//        {
//        let objectStub = ObjectStub(host: _hostname,port:_port,objectId:"0000-0000-0000-0000",interfaceId:"CORBA::ORB")
//        let invocation = try localORB.invocation(messageKind: .orbRequest,on: objectStub, operationId: "_create")
//        invocation.marshaller().marshal(type.interfaceId())
//        try invocation.invoke(expect:.orbResponse)
//        let resultKind = invocation.unmarshaller().unmarshal(CORBA.ResultKind.self)
//        let result = invocation.unmarshaller().unmarshal(T.self)
//        return(result as! T)
//        }
    
    public func registerBOA(_ boa:BasicObjectAdaptor.Type,forInterfaceId:String)
        {
        fatalError()
        }
    
    public func registerImplementation(_ object:Implementation,forObjectId:String)
        {
        fatalError()
        }
    
    public func deregisterImplementation(_ object:Implementation)
        {
        fatalError()
        }
    
    public func run()
        {
        fatalError()
        }
    }
