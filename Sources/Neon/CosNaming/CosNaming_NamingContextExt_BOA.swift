//
// Generated by Coral
// Generated from IDLBOA
//

import Foundation

public class CosNaming_NamingContextExt_BOA:CosNaming_NamingContext_BOA
    {
    public override var interfaceId:InterfaceId
        {
        return(InterfaceId("CosNaming::NamingContextExt"))
        }

    public override func createInstance() -> CORBA_Object
        {
        return(CosNaming_NamingContextExt_Implementation())
        }

    public override func respondsTo(operation:String) -> Bool
        {
        switch(operation)
            {
            
            
            case "to_url":
                return(true)
            
            case "resolve_str":
                return(true)
            
            case "to_name":
                return(true)
            
            case "to_string":
                return(true)
            
            default:
                break
            }
        return(super.respondsTo(operation:operation))
        }

    public override func invoke(operation:String,on:Implementation,outof unmarshaller:IIOPUnmarshaller,into marshaller:IIOPMarshaller) throws
        {
        let instance = on as! CosNaming_NamingContextExt_Implementation
        switch(operation)
            {
            
            
            case "to_url":
                
                
                    
                    let address = unmarshaller.unmarshal(CosNaming_Address.self)
                    
                
                
                
                    
                    let name = unmarshaller.unmarshal(CosNaming_StringName.self)
                    
                
                
                
                let invocation_result = try instance.to_url(address:address,name:name)
                
                marshaller.marshal(CORBA.ResultKind.success)
                
                
                
                
                
                marshaller.marshal(invocation_result)
            
            case "resolve_str":
                
                
                    
                    let name = unmarshaller.unmarshal(CosNaming_StringName.self)
                    
                
                
                
                let invocation_result = try instance.resolve_str(name:name)
                
                marshaller.marshal(CORBA.ResultKind.success)
                
                
                
                marshaller.marshal(invocation_result)
            
            case "to_name":
                
                
                    
                    let stringName = unmarshaller.unmarshal(CosNaming_StringName.self)
                    
                
                
                
                let invocation_result = try instance.to_name(stringName:stringName)
                
                marshaller.marshal(CORBA.ResultKind.success)
                
                
                
                marshaller.marshal(invocation_result)
            
            case "to_string":
                
                
                    
                    let name = unmarshaller.unmarshal(CosNaming_Name.self)
                    
                
                
                
                let invocation_result = try instance.to_string(name:name)
                
                marshaller.marshal(CORBA.ResultKind.success)
                
                
                
                marshaller.marshal(invocation_result)
            
        default:
            try super.invoke(operation:operation,on:on,outof:unmarshaller,into:marshaller)
            }
        }
    }
