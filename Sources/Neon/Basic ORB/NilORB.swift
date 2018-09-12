//
//  NilORB.swift
//  Jet
//
//  Created by Vincent Coetzee on 2018/09/08.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public struct NilORB:ORB
    {
    public func namingService() -> CosNaming_NamingContext
        {
        return(CosNaming_NamingContext_Implementation())
        }
    
    public func create<T>(_ type: T.Type) throws -> T where T : ObjectStub
        {
        fatalError()
        }
    
    public var queue:DispatchQueue
        {
        fatalError()
        }
    
    public var host:String
        {
        fatalError()
        }
    
    public var port:Int
        {
        fatalError()
        }
    
    public func destroy(object:CORBA_Object) throws
        {
        }
        
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
