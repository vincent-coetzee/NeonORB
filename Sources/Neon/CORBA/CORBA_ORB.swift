//
// Generated by Coral
// Generated from IDLProtocol
//
public protocol CORBA_ORB:CORBA_Object
    {
    
    
    func destroy(object: CORBA_Object) throws -> Void
    
    func create(interfaceId: String) throws -> CORBA_Object
    
    }