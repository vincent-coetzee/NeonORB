////
////  ConcreteNamingContext.swift
////  Jet
////
////  Created by Vincent Coetzee on 2018/09/04.
////  Copyright © 2018 Vincent Coetzee. All rights reserved.
////
//
//import Foundation
//
//public protocol NamedItem
//    {
//    var name:String { get }
//    var container:NamedItemContainer? { get }
//    var isObject:Bool { get }
//    var isContext:Bool { get }
//    func find(_ name:CosNaming_Name) -> NamedItem?
//    }
//
//public protocol NamedItemContainer:NamedItem
//    {
//    }
//    
//public class NamingContainer:NamedItemContainer,CORBA_Object
//    {
//    public var host: String
//    public var port: Int
//    public var objectId: String
//    public var interfaceId: InterfaceId
//    public var orb: ORB
//
//    internal var entries:[String:NamedItem] = [:]
//
//    public func find(_ names:CosNaming_Name) -> NamedItem?
//        {
//        guard !names.isEmpty,let entry = entries[names[0].id] else
//            {
//            return(nil)
//            }
//        if names.count == 1 && names.first!.id == self.name
//            {
//            return(self)
//            }
//        return(entry.find(Array(names.dropFirst())))
//        }
//        
//    public func remove(_ object:NamingEntry)
//        {
//        entries[object.name] = nil
//        }
//        
//    public func setObject(_ object:CORBA_Object,forName name:CosNaming_Name)
//        {
//        guard name.count > 1 else
//            {
//            let part = name.first!.id
//            entries[part] = NamingEntry(name:part,object:object)
//            return
//            }
//        guard let context = entries[name.first!.id] as? NamingContainer else
//            {
//            return
//            }
//        context.setObject(object,forName:Array(name.dropFirst()))
//        }
//    }
//    
//public class RootNamingContext:NamingContainer
//    {
//    public static let root = RootNamingContext(name:"",object:ObjectStub.nil)
//    
//    public override var nameList:[String]
//        {
//        return([])
//        }
//    }
//    
//public class ChildNamingContext:NamingContainer
//    {
//    public let parent:NamingContainer
//    
//    public override var nameList:[String]
//        {
//        return(parent.nameList.appending(self.name))
//        }
//        
//    init(name:String,object:CORBA_Object,parent:NamingContainer)
//        {
//        self.parent = parent
//        super.init(name:name,object:object)
//        }
//        
//    public func add(_ entry:NamingEntry)
//        {
//        entries[entry.name] = entry
//        entry.container = self
//        }
//    }
//
//extension Array
//    {
//    public func appending(_ element:Element) -> Array<Element>
//        {
//        var newArray = self
//        newArray.append(element)
//        return(newArray)
//        }
//    }
