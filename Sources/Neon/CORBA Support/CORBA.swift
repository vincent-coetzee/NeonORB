//
//  CORBA.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/28.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public struct CORBA
    {
    internal static let kIIOPBufferSize = 1024 * 128
    
    public enum MessageKind:Int,Equatable
        {
        case ping
        case pong
        case request
        case response
        case forward
        case end
        }
    
    public enum ResultKind:Int
        {
        case corbaException
        case systemException
        case success
        }
    
    public enum InvocationResultKind:Int,Error
        {
        case ok
        case exception
        case unknown
        }
    
    public enum TypeCode:Int
        {
        case null = 0
        case exception = 1
        case `struct` = 2
        case `enum` = 3
        }
    
    public enum ORBError:Int,Error
        {
        case unknown
        case marshalling
        case unmarshalling
        case remote
        case ethernetAddressNotFound
        case badRequestSize
        case badObjectReference
        case badOperation
        case badMessage
        case invocationTimeout
        case invalidTypes
        }
    
    open class Exception:Error
        {
        public init()
            {
            }
            
        open func marshal(on:IIOPMarshaller)
            {
            fatalError()
            }
        }
    
    public static var orb:ORB = NilORB()
    }

extension Array where Element == String
    {
    public func asCosName() -> CosNaming_Name
        {
        return(self.map{CosNaming_NameComponent(id:$0,kind:"")})
        }
        
    public func appending(_ element:Element) -> Array<Element>
        {
        var newArray = self
        newArray.append(element)
        return(newArray)
        }
    }
