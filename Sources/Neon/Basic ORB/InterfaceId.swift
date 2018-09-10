//
//  InterfaceId.swift
//  CORBA
//
//  Created by Vincent Coetzee on 2018/08/27.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public struct InterfaceId:ExpressibleByStringLiteral,Equatable
{
    public typealias StringLiteralType = String
    
    public let rawValue:String
    
    public init(stringLiteral rawValue:String)
        {
        self.rawValue = rawValue
        }
    
    public init(_ value:String)
        {
        self.rawValue = value
        }
    }
