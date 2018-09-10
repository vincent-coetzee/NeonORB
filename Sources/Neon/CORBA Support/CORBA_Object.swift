//
//  CORBA_Object_Protocol.swift
//  Jet
//
//  Created by Vincent Coetzee on 2018/09/05.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public protocol CORBA_Object
    {
    var host:String { get }
    var port:Int { get }
    var objectId:String { get }
    var interfaceId:InterfaceId { get }
    func narrow<T:ObjectStub>(_ type:T.Type) throws -> T
    }

