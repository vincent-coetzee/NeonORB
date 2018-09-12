//
// Generated by Coral
// Generated from IDLClient
//
//
public class CosNaming_BindingIterator_Interface:ObjectStub,CosNaming_BindingIterator
    {
    public override class func interfaceId() -> InterfaceId
        {
        return("CosNaming::BindingIterator")
        }

    

    public required init(host:String,port:Int,objectId:String,interfaceId:InterfaceId)
        {
        super.init(host:host,port:port,objectId:objectId,interfaceId:interfaceId)
        }

    

    public static func ==(lhs:CosNaming_BindingIterator_Interface,rhs:CosNaming_BindingIterator_Interface) -> Bool
        {
        guard lhs.host == rhs.host else 
            {
            return(false)
            }
        guard lhs.port == rhs.port else
            {
            return(false)
            }
        guard lhs.objectId == rhs.objectId else
            {
            return(false)
            }
        guard lhs.interfaceId == rhs.interfaceId else
            {
            return(false)
            }
        return(true)
        }
        
    
    // []
    public func next_n(how_many: UInt32,binding_list:inout CosNaming_BindingList) throws -> Bool
        {
        let invocation = self.invocation(forOperation: "next_n")
        let marshaller = invocation.marshaller()
        
            
            marshaller.marshal(how_many)
            
        
            
        
        try invocation.invoke(expect: .response)
        let unmarshaller = invocation.unmarshaller()
        let resultKind = unmarshaller.unmarshal(CORBA.ResultKind.self)
        switch(resultKind)
            {
            case .systemException:
                throw(CORBA.ORBError(rawValue: unmarshaller.unmarshal(Int.self))!)
            case .corbaException:
                
                break
                
            default:
                break
            }
        
            
        
            
                binding_list = unmarshaller.unmarshal(CosNaming_BindingList.self)
            
        
        return(invocation.unmarshaller().unmarshal(Bool.self))
        }
    
    // []
    public func destroy() throws -> Void
        {
        let invocation = self.invocation(forOperation: "destroy")
        let marshaller = invocation.marshaller()
        
        try invocation.invoke(expect: .response)
        let unmarshaller = invocation.unmarshaller()
        let resultKind = unmarshaller.unmarshal(CORBA.ResultKind.self)
        switch(resultKind)
            {
            case .systemException:
                throw(CORBA.ORBError(rawValue: unmarshaller.unmarshal(Int.self))!)
            case .corbaException:
                
                break
                
            default:
                break
            }
        
        return(invocation.unmarshaller().unmarshal(Void.self))
        }
    
    // []
    public func next_one(b:inout CosNaming_Binding) throws -> Bool
        {
        let invocation = self.invocation(forOperation: "next_one")
        let marshaller = invocation.marshaller()
        
            
        
        try invocation.invoke(expect: .response)
        let unmarshaller = invocation.unmarshaller()
        let resultKind = unmarshaller.unmarshal(CORBA.ResultKind.self)
        switch(resultKind)
            {
            case .systemException:
                throw(CORBA.ORBError(rawValue: unmarshaller.unmarshal(Int.self))!)
            case .corbaException:
                
                break
                
            default:
                break
            }
        
            
                b = unmarshaller.unmarshal(CosNaming_Binding.self)
            
        
        return(invocation.unmarshaller().unmarshal(Bool.self))
        }
    
    }


//
// Generated by Coral
// Generated from IDLClientMarshalling
//
//
extension IIOPUnmarshaller
    {
    public func unmarshal(_ value: CosNaming_BindingIterator.Protocol) -> CosNaming_BindingIterator?
        {
        let isNil = self.unmarshal(Bool.self)
        if isNil
            {
            return(nil)
            }
        let host = self.unmarshal(String.self)
        let port = self.unmarshal(Int.self)
        let objectId = self.unmarshal(String.self)
        let interfaceId = self.unmarshal(String.self)
        return(CosNaming_BindingIterator_Interface(host:host,port:port,objectId:objectId,interfaceId:InterfaceId(interfaceId)))
        }
    }

extension IIOPMarshaller
    {
    public func marshal(_ value: CosNaming_BindingIterator?)
        {
        guard let value = value else
            {
            self.marshal(true)
            return
            }
        self.marshal(false)
        self.marshal(value.host)
        self.marshal(value.port)
        self.marshal(value.objectId)
        self.marshal(value.interfaceId)
        }
    }
