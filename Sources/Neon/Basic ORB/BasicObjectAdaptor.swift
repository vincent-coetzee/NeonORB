//
//  CORBABOA.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/27.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

open class BasicObjectAdaptor
    {
    open var interfaceId:InterfaceId
        {
        return(InterfaceId("CORBA::Object"))
        }
    
    public required init()
        {
        }
    
    open func createInstance() -> CORBA_Object
        {
        return(Implementation())
        }
    
    open func respondsTo(operation:String) -> Bool
        {
        return(false)
        }
    
    open func invoke(operation:String,on instance:Implementation,outof unmarshaller:IIOPUnmarshaller,into marshaller:IIOPMarshaller) throws
        {
        }
    }
