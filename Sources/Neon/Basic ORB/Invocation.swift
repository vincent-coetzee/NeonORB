//
//  Invocation.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/28.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation
import Socket

open class Invocation
    {
    private var _marshaller:IIOPMarshaller!
    private var _unmarshaller:IIOPUnmarshaller!
    private var socket:Socket
    private var semaphore:DispatchSemaphore!
    private var myQueue:DispatchQueue!
    private var object:ObjectStub
    
    public init(object:ObjectStub,socket:Socket)
        {
        self.socket = socket
        self.object = object
        }
    
    public func setInputBuffer(_ buffer:UnsafeMutableRawBufferPointer,ofSize:Int)
        {
        _marshaller = IIOPMarshaller(buffer:buffer,bufferSize:ofSize)
        }
    
    public func set(messageKind:CORBA.MessageKind,operationId:String)
        {
        _marshaller = IIOPMarshaller(bufferSize: CORBA.kIIOPBufferSize)
        _marshaller.marshal(CORBA.kNeonMagicNumber)
        _marshaller.marshal(messageKind)
        _marshaller.marshal(object)
        _marshaller.marshal(operationId)
        }
    
    public func invoke(expect:CORBA.MessageKind) throws
        {
        let bytes = _marshaller.bytes
        var incoming = Data(capacity: CORBA.kIIOPBufferSize)
        try socket.setReadTimeout(value: CORBA.kInvocationTimeoutInSeconds * 1000)
        try socket.write(from: bytes)
        let bytesRead = try socket.read(into: &incoming)
        SocketPool.shared.add(socket:socket)
        if bytesRead == 0
            {
            throw(CORBA.ORBError.invocationTimeout)
            }
        _unmarshaller = IIOPUnmarshaller(bytes:incoming)
        let dataLength = _unmarshaller.unmarshal(Int.self)
        if dataLength != bytesRead
            {
            throw(CORBA.ORBError.badRequestSize)
            }
        if _unmarshaller.unmarshal(Int32.self) != CORBA.kNeonMagicNumber
            {
            throw(CORBA.ORBError.notNeonMessage)
            }
        if _unmarshaller.unmarshal(CORBA.MessageKind.self) != expect
            {
            throw(CORBA.ORBError.badMessage)
            }
        }
    
    public func marshaller() -> IIOPMarshaller
        {
        return(_marshaller)
        }
    
    public func unmarshaller() -> IIOPUnmarshaller
        {
        return(_unmarshaller)
        }
    }
