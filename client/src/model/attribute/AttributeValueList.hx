package model.attribute;

import assertions.Assert ;


private class AttributeValuePair {
    public var attribute( default, null ) : Attribute<Dynamic> ;
    public var value( default, default ) : AttributeValue ;

    public function new( attribute : Attribute<Dynamic> ) {
        this.attribute = attribute ;
        this.value = attribute.getDefaultValue() ;
    }
}

class AttributeValueList {

    var pairMap : Map<Attribute<Dynamic>, AttributeValuePair> ;

    public function new( attributes : Iterator<Attribute<AttributeValue>> ) {
        pairMap = new Map<Attribute<AttributeValue>, AttributeValuePair>() ;
        for( attr in attributes ) {
            var p = new AttributeValuePair( attr ) ;
            pairMap.set( attr, p ) ;
        }
    }
    public function get<ValueType : AttributeValue>( attribute : Attribute<ValueType> ) : ValueType {
        return cast( getUntyped( attribute ) ) ;
    }
    public function getUntyped( attribute : Attribute<Dynamic> ) : AttributeValue {
        var p : AttributeValuePair = pairMap.get( attribute ) ;
        Assert.assert( p != null ) ;
        return p.value ;
    }
    
    public function set<ValueType : AttributeValue>( attribute : Attribute<ValueType>, newValue : ValueType ) {
        var p : AttributeValuePair = pairMap.get( attribute ) ;
        Assert.assert( p != null ) ;
        p.value = newValue ;
    }
    public function has<ValueType : AttributeValue>( attribute : Attribute<ValueType> ) : Bool {
        var a : Attribute<AttributeValue> = cast( attribute ) ;
        return pairMap.exists( a ) ;
    }
}