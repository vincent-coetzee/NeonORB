//
// Generated by Coral
// Generated from IDLProtocol
//
public protocol CosNaming_NamingContext:CORBA_Object
    {
    
    
    func rebind_context(n: CosNaming_Name,naming_context: CosNaming_NamingContext?) throws -> Void
    
    func bind_new_context(n: CosNaming_Name) throws -> CosNaming_NamingContext?
    
    func bind(n: CosNaming_Name,object: CORBA_Object?) throws -> Void
    
    func unbind(n: CosNaming_Name) throws -> Void
    
    func rebind(n: CosNaming_Name,object: CORBA_Object?) throws -> Void
    
    func list(how_many: UInt32,binding_list:inout CosNaming_BindingList,binding_iterator:inout CosNaming_BindingIterator?) throws -> Void
    
    func destroy() throws -> Void
    
    func bind_context(n: CosNaming_Name,naming_context: CosNaming_NamingContext?) throws -> Void
    
    func new_context() throws -> CosNaming_NamingContext?
    
    func resolve(n: CosNaming_Name) throws -> CORBA_Object?
    
    }
