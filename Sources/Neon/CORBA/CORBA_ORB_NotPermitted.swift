//
// Generated by Coral
// Generated from IDLException
//
public class CORBA_ORB_NotPermitted:CORBA.Exception
    {
    

    

    public override func marshal(on marshaller:IIOPMarshaller)
        {
        marshaller.marshal("CORBA::ORB::NotPermitted")
        
        }
    }

//
// Generated by Coral
// Generated from IDLExceptionMarshalling
//
extension IIOPUnmarshaller
    {
    public func unmarshal(_ value:CORBA_ORB_NotPermitted.Type) -> CORBA_ORB_NotPermitted
        {
        
        let newInstance = CORBA_ORB_NotPermitted()
        return(newInstance)
        }
    }

extension IIOPMarshaller
    {
    public func marshal(_ value:CORBA_ORB_NotPermitted)
        {
        self.marshal("CORBA::ORB::NotPermitted")
        
        }
    }

