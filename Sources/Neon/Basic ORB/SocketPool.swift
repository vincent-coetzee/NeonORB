//
//  SocketPool.swift
//  Jet
//
//  Created by Vincent Coetzee on 2018/09/07.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation
import Socket

public class SocketPool
    {
    private static let kMaximumSockets = 512
    private static let kMinimumSockets = 16
    
    public static let shared = SocketPool()
    
    private var sockets:[String:[Socket]] = [:]
    
    public func remove(forHost host:String,onPort port:Int) -> Socket?
        {
        let key = "\(host):\(port)"
        guard let socketList = sockets[key],let socket = socketList.first else
            {
            return(nil)
            }
        sockets[key] = Array(socketList.dropFirst())
        if self.isValid(socket:socket)
            {
            return(socket)
            }
        return(self.remove(forHost:host,onPort:port))
        }
    
    private func isValid(socket:Socket) -> Bool
        {
        do
            {
            let bytes = IIOPBuffer.pingBytes
            try socket.write(from: bytes)
            var resultBytes = Data(capacity:1024)
            let bytesRead = try socket.read(into: &resultBytes)
            guard bytesRead == MemoryLayout<Int>.size*2 else
                {
                socket.close()
                return(false)
                }
            let unmarshaller = IIOPUnmarshaller(bytes:resultBytes)
            let length = unmarshaller.unmarshal(Int.self)
            guard length == bytesRead else
                {
                socket.close()
                return(false)
                }
            guard unmarshaller.unmarshal(CORBA.MessageKind.self) == CORBA.MessageKind.pong else
                {
                socket.close()
                return(false)
                }
            return(true)
            }
        catch
            {
            socket.close()
            return(false)
            }
        }
    
    public func add(socket:Socket)
        {
        guard let signature = socket.signature,let host = signature.hostname else
            {
            socket.close()
            return
            }
        let port = signature.port
        let key = "\(host):\(port)"
        var socketList = sockets[key] ?? []
        socketList.append(socket)
        sockets[key] = socketList
        }
    }

