//
//  IIOPMarshaller.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/27.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

open class IIOPMarshaller:IIOPBuffer
    {
    public var pingBytes:Data
        {
        self.rewind()
        self.marshal(0)
        self.marshal(CORBA.kNeonMagicNumber)
        self.marshal(CORBA.MessageKind.ping)
        return(self.bytes)
        }
    
    public var pongBytes:Data
        {
        self.rewind()
        self.marshal(0)
        self.marshal(CORBA.kNeonMagicNumber)
        self.marshal(CORBA.MessageKind.pong)
        return(self.bytes)
        }
    
    public func bytes(forORBImplementing interfaceId:InterfaceId) -> Data
        {
        self.marshal(CORBA.MessageKind.request)
        self.marshal(interfaceId)
        return(self.bytes)
        }
    
    public func requestBytes(for string:String) -> Data
        {
        self.marshal(CORBA.MessageKind.request)
        self.marshal(string)
        return(self.bytes)
        }
    
    public func marshal(_ int:Int)
        {
        buffer.storeBytes(of: int, toByteOffset: offset, as: Int.self)
        offset += MemoryLayout<Int>.size
        }
    
    public func marshal(_ byte:UInt8)
        {
        buffer.storeBytes(of: byte, toByteOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        align(to: Int.self)
        }
    
    public func marshal(_ int:UInt32)
        {
        buffer.storeBytes(of: int, toByteOffset: offset, as: UInt32.self)
        offset += MemoryLayout<UInt32>.size
        align(to: Int.self)
        }
    
    public func marshal(_ int:Int32)
        {
        buffer.storeBytes(of: int, toByteOffset: offset, as: Int32.self)
        offset += MemoryLayout<Int32>.size
        }
    
    public func marshal(_ int:UInt64)
        {
        buffer.storeBytes(of: int, toByteOffset: offset, as: UInt64.self)
        offset += MemoryLayout<UInt64>.size
        align(to: Int.self)
        }
    
    public func marshal(_ int:Int64)
        {
        buffer.storeBytes(of: int, toByteOffset: offset, as: Int64.self)
        offset += MemoryLayout<Int64>.size
        }
    
    public func marshal(_ float:Float)
        {
        buffer.storeBytes(of: float, toByteOffset: offset, as: Float.self)
        offset += MemoryLayout<Float>.size
        }
    
    public func marshal(_ double:Double)
        {
        buffer.storeBytes(of: double, toByteOffset: offset, as: Double.self)
        offset += MemoryLayout<Double>.size
        }
    
    public func marshal(_ boolean:Bool)
        {
        buffer.storeBytes(of: boolean, toByteOffset: offset, as: Bool.self)
        offset += MemoryLayout<Bool>.size
        }
    
    public func marshal(_ string:String)
        {
        let scalars = string.unicodeScalars
        align(to: Int.self)
        buffer.storeBytes(of: scalars.count,toByteOffset: offset, as: Int.self)
        offset += MemoryLayout<Int>.size
        for scalar in scalars
            {
            buffer.storeBytes(of: scalar,toByteOffset: offset,as: UnicodeScalar.self)
            offset += MemoryLayout<UnicodeScalar>.size
            }
        align(to: UInt.self)
        }
    
    public func marshal(_ object:Void)
        {
        }
    
    public func marshal(_ interfaceId:InterfaceId)
        {
        self.marshal(interfaceId.rawValue)
        }
    
    public func marshal(_ value:CORBA.Exception)
        {
        value.marshal(on:self)
        }
    
    public func marshal(_ value:CORBA.IDLAny)
        {
        fatalError()
        }
    
    public func marshal(_ strings:Array<String>)
        {
        self.marshal(strings.count)
        for string in strings
            {
            self.marshal(string)
            }
        align(to: Int.self)
        }
    
    public func marshal(_ bytes:Array<UInt8>)
        {
        self.marshal(bytes.count)
        for byte in bytes
            {
            self.marshal(byte)
            }
        align(to: Int.self)
        }
    
    public func marshal<T>(_ value:T,atOffset:Int? = nil) where T:RawRepresentable,T.RawValue == Int
        {
        marshal(value.rawValue)
        }
    
    public func marshal(_ reference:CORBA_Object?)
        {
        guard let reference = reference else
            {
            self.marshal(true)
            return
            }
        self.marshal(false)
        self.marshal(reference.host)
        self.marshal(reference.port)
        self.marshal(reference.objectId)
        self.marshal(reference.interfaceId.rawValue)
        }
    }

extension Data
    {
    func print()
        {
        for index in stride(from:0,to:self.count,by:8)
            {
            for loop in index..<Swift.min(index+8,self.count)
                {
                let byte = self[loop]
                Swift.print(String(format: "%02X",byte),separator:" ",terminator:" ")
                }
            Swift.print()
            }
        }
    }
