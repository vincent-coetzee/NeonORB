//
//  Implementation.swift
//  Jet
//
//  Created by Vincent Coetzee on 2018/09/04.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

open class Implementation:ObjectStub
    {
    public init()
        {
        super.init(host:"",port:0,objectId:UUID().uuidString,interfaceId:"CORBA::Object")
        }
    
    public required init(host:String,port:Int,objectId:String,interfaceId:InterfaceId)
        {
        super.init(host:host,port:port,objectId:objectId,interfaceId:interfaceId)
        }
    
    open func activateObject()
        {
        }
        
    open func deactivateObject()
        {
        }
    
    open func destroyObject()
        {
        }
    }
