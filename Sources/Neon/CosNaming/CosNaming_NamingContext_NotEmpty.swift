//
// Generated by Coral
// Generated from IDLException
//
public class CosNaming_NamingContext_NotEmpty:CORBA.Exception
    {
    

    

    public override func marshal(on marshaller:IIOPMarshaller)
        {
        marshaller.marshal("CosNaming::NamingContext::NotEmpty")
        
        }
    }

//
// Generated by Coral
// Generated from IDLExceptionMarshalling
//
extension IIOPUnmarshaller
    {
    public func unmarshal(_ value:CosNaming_NamingContext_NotEmpty.Type) -> CosNaming_NamingContext_NotEmpty
        {
        
        let newInstance = CosNaming_NamingContext_NotEmpty()
        return(newInstance)
        }
    }

extension IIOPMarshaller
    {
    public func marshal(_ value:CosNaming_NamingContext_NotEmpty)
        {
        self.marshal("CosNaming::NamingContext::NotEmpty")
        
        }
    }

