//
// Generated by Coral
// Generated from IDLImplementation
//

import Foundation

public class CosNaming_BindingIterator_Implementation:Implementation,CosNaming_BindingIterator
    {
    internal var entries:[String:NamedItemHolder] = [:]
    internal var index:Int = 0
    
    public override init()
        {
        super.init()
        interfaceId = "CosNaming::BindingIterator"
        CORBA.orb.registerBOA(CosNaming_BindingIterator_BOA.self,forInterfaceId:"CosNaming::BindingIterator")
        CORBA.orb.registerImplementation(self,forObjectId: self.objectId)
        }

    public required init(host:String,port:Int,objectId:String,interfaceId:InterfaceId)
        {
        super.init(host:host,port:port,objectId:objectId,interfaceId:interfaceId)
        }
    // Attributes
    
    
    // 
    public func destroy() throws -> Void
        {
        CORBA.orb.deregisterImplementation(self)
        }
    
    // 
    public func next_n(how_many: UInt32,binding_list:inout CosNaming_BindingList) throws -> Bool
        {
        return(false)
        }
    
    // 
    public func next_one(b:inout CosNaming_Binding) throws -> Bool
        {
        return(false)
        }
    
    }
