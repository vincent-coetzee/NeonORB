//
// Generated by Coral
// Generated from IDLStruct
//
//
public struct CosNaming_NameComponent
    {
    
        var id:CosNaming_Istring
    
        var kind:CosNaming_Istring
    

    public init(id:CosNaming_Istring,kind:CosNaming_Istring)
        {
        
        self.id = id
        
        self.kind = kind
        
        }
    }


//
// Generated by Coral
// Generated from IDLStructMarshalling
//
extension IIOPUnmarshaller
    {
    public func unmarshal(_ value:CosNaming_NameComponent.Type) -> CosNaming_NameComponent
        {
        
        let id = self.unmarshal(CosNaming_Istring.self)
        
        let kind = self.unmarshal(CosNaming_Istring.self)
        
        let newInstance = CosNaming_NameComponent(id:id,kind:kind)
        return(newInstance)
        }
    }

extension IIOPMarshaller
    {
    public func marshal(_ value:CosNaming_NameComponent)
        {
        
        self.marshal(value.id)
        
        self.marshal(value.kind)
        
        }
    }
