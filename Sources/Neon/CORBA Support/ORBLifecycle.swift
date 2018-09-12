//
//  ORBLifecycle.swift
//  HeliumLogger
//
//  Created by Vincent Coetzee on 2018/09/12.
//

import Foundation

public protocol ORBLifecycle
    {
    func createImplementation() throws
    func activateImplementation(buffer:IIOPUnmarshaller) throws
    func deactivateImplementation(buffer:IIOPMarshaller) throws
    func destroyImplementation() throws
    }
