//
// Generated by Coral
// Generated from IDLException
//
public class CosNaming_NamingContext_CannotProceed:CORBA.Exception
    {
    
        var cxt:CosNaming_NamingContext
    
        var rest_of_name:CosNaming_Name
    

    
    public init(cxt:CosNaming_NamingContext,rest_of_name:CosNaming_Name)
        {
        
        self.cxt = cxt
        
        self.rest_of_name = rest_of_name
        
        }
    

    public override func marshal(on marshaller:IIOPMarshaller)
        {
        marshaller.marshal("CosNaming::NamingContext::CannotProceed")
        
        marshaller.marshal(self.cxt)
        
        marshaller.marshal(self.rest_of_name)
        
        }
    }

//
// Generated by Coral
// Generated from IDLExceptionMarshalling
//
extension IIOPUnmarshaller
    {
    public func unmarshal(_ value:CosNaming_NamingContext_CannotProceed.Type) -> CosNaming_NamingContext_CannotProceed
        {
        
        let cxt = self.unmarshal(CosNaming_NamingContext.self)
        
        let rest_of_name = self.unmarshal(CosNaming_Name.self)
        
        let newInstance = CosNaming_NamingContext_CannotProceed(cxt:cxt,rest_of_name:rest_of_name)
        return(newInstance)
        }
    }

extension IIOPMarshaller
    {
    public func marshal(_ value:CosNaming_NamingContext_CannotProceed)
        {
        self.marshal("CosNaming::NamingContext::CannotProceed")
        
        self.marshal(value.cxt)
        
        self.marshal(value.rest_of_name)
        
        }
    }

