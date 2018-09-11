//
//  IIOPBuffer.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/27.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public class IIOPBuffer
    {
    internal var offset:Int
    internal var bufferSize:Int
    internal var buffer:UnsafeMutableRawBufferPointer
    internal var alignment:Int
    
    public static let pingBytes =
        {
        return(IIOPMarshaller().pingBytes)
        }()
    
    public static let pongBytes =
        {
        return(IIOPMarshaller().pongBytes)
        }()
    
    public var bytes:Data
        {
        buffer.storeBytes(of: offset, toByteOffset: 0, as: Int.self)
        let bytes = Array(buffer[0..<offset])
        return(Data(bytes: bytes))
        }
    
    public static func bytes(forORBImplementing interfaceId:InterfaceId) -> Data
        {
        return(IIOPMarshaller().bytes(forORBImplementing:interfaceId))
        }
    
    init(bytes:Data)
        {
        bufferSize = bytes.count * 2
        buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: bufferSize, alignment: MemoryLayout<UInt>.alignment)
        let pointer = buffer.baseAddress!.assumingMemoryBound(to: UInt8.self)
        bytes.copyBytes(to: pointer, count: bytes.count)
        offset = MemoryLayout<Int>.size
        alignment = MemoryLayout<UInt>.alignment
        }
        
    init(bufferSize:Int = 4096)
        {
        alignment = MemoryLayout<UInt>.alignment
        offset = MemoryLayout<Int>.size
        self.bufferSize = bufferSize
        buffer = UnsafeMutableRawBufferPointer.allocate(byteCount: bufferSize, alignment: MemoryLayout<UInt>.alignment)
        }
    
    init(buffer:UnsafeMutableRawBufferPointer,bufferSize:Int)
        {
        alignment = MemoryLayout<UInt>.alignment
        self.buffer = buffer
        self.bufferSize = bufferSize
        self.offset = 0 
        }
    
    private func grow()
        {
        let newSize = self.bufferSize * 5 / 3
        let newBuffer = UnsafeMutableRawBufferPointer.allocate(byteCount: newSize, alignment: MemoryLayout<UInt>.alignment)
        newBuffer.copyMemory(from: UnsafeRawBufferPointer(buffer))
        buffer = newBuffer
        bufferSize = newSize
        }
        
    public func rewind()
        {
        offset = 0
        }
    
    @inline(__always)
    internal func align<T>(to:T.Type)
        {
        offset = (offset + (MemoryLayout<T>.alignment - 1)) & -MemoryLayout<T>.alignment
        }
    
    @discardableResult
    func reserveSpace<T>(for:T.Type) -> Int
        {
        let oldOffset = offset
        offset += MemoryLayout<T>.size
        return(oldOffset)
        }
    }
