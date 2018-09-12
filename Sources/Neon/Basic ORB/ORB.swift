 //
//  ORB.swift
//  Algae
//
//  Created by Vincent Coetzee on 2018/09/06.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import Foundation

public protocol ORB
    {
    var host:String { get }
    var port:Int { get }
    func namingService() -> CosNaming_NamingContext
    func registerBOA(_ boa:BasicObjectAdaptor.Type,forInterfaceId:String)
    func registerImplementation(_ object:Implementation,forObjectId:String)
    func deregisterImplementation(_ object:Implementation)
    func run()
    }

