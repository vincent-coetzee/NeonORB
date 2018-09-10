//
// Generated by Coral
// Generated from IDLClient
//
//
public class CORBA_ORB_Interface:ObjectStub,CORBA_ORB
    {
    public override class func interfaceId() -> InterfaceId
        {
        return("CORBA::ORB")
        }

    

    public required override init(host:String,port:Int,objectId:String,interfaceId:InterfaceId)
        {
        super.init(host:host,port:port,objectId:objectId,interfaceId:interfaceId)
        }

    

    public static func ==(lhs:CORBA_ORB_Interface,rhs:CORBA_ORB_Interface) -> Bool
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
        
    
    // [["interfaceId": "CORBA::ORB::NotFound", "name": "CORBA_ORB_NotFound"], ["interfaceId": "CORBA::ORB::NotPermitted", "name": "CORBA_ORB_NotPermitted"]]
    public func destroy(object: CORBA_Object) throws -> Void
        {
        let invocation = self.invocation(forOperation: "destroy")
        let marshaller = invocation.marshaller()
        
            
            marshaller.marshal(object)
            
        
        try invocation.invoke(expect: .response)
        let unmarshaller = invocation.unmarshaller()
        let resultKind = unmarshaller.unmarshal(CORBA.ResultKind.self)
        switch(resultKind)
            {
            case .systemException:
                throw(CORBA.ORBError(rawValue: unmarshaller.unmarshal(Int.self))!)
            case .corbaException:
                
                let exceptionId = unmarshaller.unmarshal(String.self)
                switch(exceptionId)
                    {
                    
                    case "CORBA::ORB::NotFound":
                        let error = unmarshaller.unmarshal(CORBA_ORB_NotFound.self)
                        throw(error)
                    
                    case "CORBA::ORB::NotPermitted":
                        let error = unmarshaller.unmarshal(CORBA_ORB_NotPermitted.self)
                        throw(error)
                    
                    default:
                        break
                    }
                
            default:
                break
            }
        
            
        
        return(invocation.unmarshaller().unmarshal(Void.self))
        }
    
    // [["interfaceId": "CORBA::ORB::NotFound", "name": "CORBA_ORB_NotFound"], ["interfaceId": "CORBA::ORB::NotPermitted", "name": "CORBA_ORB_NotPermitted"]]
    public func create(interfaceId: String) throws -> CORBA_Object
        {
        let invocation = self.invocation(forOperation: "create")
        let marshaller = invocation.marshaller()
        
            
            marshaller.marshal(interfaceId)
            
        
        try invocation.invoke(expect: .response)
        let unmarshaller = invocation.unmarshaller()
        let resultKind = unmarshaller.unmarshal(CORBA.ResultKind.self)
        switch(resultKind)
            {
            case .systemException:
                throw(CORBA.ORBError(rawValue: unmarshaller.unmarshal(Int.self))!)
            case .corbaException:
                
                let exceptionId = unmarshaller.unmarshal(String.self)
                switch(exceptionId)
                    {
                    
                    case "CORBA::ORB::NotFound":
                        let error = unmarshaller.unmarshal(CORBA_ORB_NotFound.self)
                        throw(error)
                    
                    case "CORBA::ORB::NotPermitted":
                        let error = unmarshaller.unmarshal(CORBA_ORB_NotPermitted.self)
                        throw(error)
                    
                    default:
                        break
                    }
                
            default:
                break
            }
        
            
        
        return(invocation.unmarshaller().unmarshal(CORBA_Object.self))
        }
    
    }


//
// Generated by Coral
// Generated from IDLClientMarshalling
//
//
extension IIOPUnmarshaller
    {
    public func unmarshal(_ value: CORBA_ORB.Protocol) -> CORBA_ORB
        {
        let host = self.unmarshal(String.self)
        let port = self.unmarshal(Int.self)
        let objectId = self.unmarshal(String.self)
        let interfaceId = self.unmarshal(String.self)
        return(CORBA_ORB_Interface(host:host,port:port,objectId:objectId,interfaceId:InterfaceId(interfaceId)))
        }
    }

extension IIOPMarshaller
    {
    public func marshal(_ value: CORBA_ORB)
        {
        self.marshal(value.host)
        self.marshal(value.port)
        self.marshal(value.objectId)
        self.marshal(value.interfaceId)
        }
    }
