//
//  IIOPUnmarshaller.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/28.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

open class IIOPUnmarshaller:IIOPBuffer
    {
    public override init(bytes:Data)
        {
        super.init(bytes:bytes)
        offset = 0
        }
    
    public func unmarshal(_ type:Int.Type) -> Int
        {
        let int = buffer.load(fromByteOffset: offset, as: Int.self)
        offset += MemoryLayout<Int>.size
        return(int)
        }
    
    public func unmarshal(_ type:UInt8.Type) -> UInt8
        {
        let int = buffer.load(fromByteOffset: offset, as: UInt8.self)
        offset += MemoryLayout<UInt8>.size
        align(to: Int.self)
        return(int)
        }
    
    public func unmarshal(_ type:UInt32.Type) -> UInt32
        {
        let int = buffer.load(fromByteOffset: offset, as: UInt32.self)
        offset += MemoryLayout<UInt32>.size
        align(to: Int.self)
        return(int)
        }
    
    public func unmarshal(_ type:Int32.Type) -> Int32
        {
        let int = buffer.load(fromByteOffset: offset, as: Int32.self)
        offset += MemoryLayout<Int32>.size
        return(int)
        }
    
    public func unmarshal(_ type:UInt64.Type) -> UInt64
        {
        let int = buffer.load(fromByteOffset: offset, as: UInt64.self)
        offset += MemoryLayout<UInt64>.size
        align(to: Int.self)
        return(int)
        }
    
    public func unmarshal(_ type:Int64.Type) -> Int64
        {
        let int = buffer.load(fromByteOffset: offset, as: Int64.self)
        offset += MemoryLayout<Int64>.size
        return(int)
        }
    
    public func unmarshal(_ type:Float.Type) -> Float
        {
        let int = buffer.load(fromByteOffset: offset, as: Float.self)
        offset += MemoryLayout<Float>.size
        return(int)
        }
    
    public func unmarshal(_ type:Double.Type) -> Double
        {
        let int = buffer.load(fromByteOffset: offset, as: Double.self)
        offset += MemoryLayout<Double>.size
        return(int)
        }
    
    public func unmarshal(_ type:Bool.Type) -> Bool
        {
        let int = buffer.load(fromByteOffset: offset, as: Bool.self)
        offset += MemoryLayout<Bool>.size
        return(int)
        }
    
    public func unmarshal(_ type:String.Type) -> String
        {
        align(to: Int.self)
        let count = self.unmarshal(Int.self)
        var string = ""
        for _ in 0..<count
            {
            let scalar = buffer.load(fromByteOffset: offset, as: UnicodeScalar.self)
            string += String(Character(scalar))
            offset += MemoryLayout<UnicodeScalar>.size
            }
        align(to: UInt.self)
        return(string)
        }
    
    public func unmarshal<T>(_ value:T.Type) -> T where T:RawRepresentable,T.RawValue == Int
        {
        let rawValue = self.unmarshal(Int.self)
        return(T(rawValue: rawValue)!)
        }
    
    public func unmarshal<T>(_ type:T.Type) -> T? where T:ObjectStub
        {
        guard !self.unmarshal(Bool.self) else
            {
            return(nil)
            }
        let host = self.unmarshal(String.self)
        let port = self.unmarshal(Int.self)
        let objectId = self.unmarshal(String.self)
        let interfaceId = self.unmarshal(String.self)
        return(T(host:host,port:port,objectId:objectId,interfaceId:InterfaceId(interfaceId)))
        }
    
    public func unmarshal(_ type:Void.Type) -> Void
        {
        return(())
        }
    
    public func unmarshal(_ type:CORBA.IDLAny.Type) -> CORBA.IDLAny
        {
        fatalError()
        }
    
    public func unmarshal(_ type:Array<String>.Type) -> Array<String>
        {
        let count = self.unmarshal(Int.self)
        var strings:[String] = []
        for _ in 0..<count
            {
            strings.append(self.unmarshal(String.self))
            }
        align(to: Int.self)
        return(strings)
        }
    
 public func unmarshal(_ type:Array<UInt8>.Type) -> Array<UInt8>
        {
        let count = self.unmarshal(Int.self)
        var strings:[UInt8] = []
        for _ in 0..<count
            {
            strings.append(self.unmarshal(UInt8.self))
            }
        align(to: Int.self)
        return(strings)
        }
    
    public func unmarshal(_ value:CORBA_Object.Protocol) -> CORBA_Object?
        {
        if self.unmarshal(Bool.self)
            {
            return(nil)
            }
        let host = self.unmarshal(String.self)
        let port = self.unmarshal(Int.self)
        let objectId = self.unmarshal(String.self)
        let interfaceId = self.unmarshal(String.self)
        return(ObjectStub(host:host,port:port,objectId:objectId,interfaceId:InterfaceId(interfaceId)))
        }
    
    public func unmarshal(_ type:CORBA.TypeCode.Type) -> CORBA.TypeCode
        {
        return(CORBA.TypeCode(rawValue: unmarshal(Int.self))!)
        }
    
    public func unmarshal(_ type:CORBA.Exception.Type) -> Error
        {
        return(CORBA.ORBError.unknown)
        }
    }
