//
// Generated by Coral
// Generated from IDLProtocol
//
public protocol CosNaming_BindingIterator:CORBA_Object
    {
    
    
    func destroy() throws -> Void
    
    func next_one(b:inout CosNaming_Binding) throws -> Bool
    
    func next_n(how_many: UInt32,binding_list:inout CosNaming_BindingList) throws -> Bool
    
    }
