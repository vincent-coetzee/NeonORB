//
//  CORBABOA.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/27.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public class BasicObjectAdaptor
    {
    public var interfaceId:InterfaceId
        {
        return(InterfaceId("CORBA::Object"))
        }
    
    public required init()
        {
        }
    
    public func createInstance() -> CORBA_Object
        {
        return(Implementation())
        }
    
    public func respondsTo(operation:String) -> Bool
        {
        return(false)
        }
    
    public func invoke(operation:String,on instance:Implementation,outof unmarshaller:IIOPUnmarshaller,into marshaller:IIOPMarshaller) throws
        {
        }
    }
