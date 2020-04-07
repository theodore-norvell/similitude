package model.attribute;

import assertions.Assert ;

class AttributeValueList {

    var pairMap : Map<Attribute<AttributeValue>, AttributeValuePair<AttributeValue>> ;

    public function new( attributes : Iterator<Attribute<AttributeValue>> ) {
        pairMap = new Map<Attribute<AttributeValue>, AttributeValuePair<AttributeValue>>() ;
        for( attr in attributes ) {
            var p = new AttributeValuePair<AttributeValue>( attr ) ;
            pairMap.set( attr, p ) ;
        }
    }
    public function get<ValueType : AttributeValue>( attribute : Attribute<ValueType> ) : ValueType {
        var a : Attribute<AttributeValue> = cast( attribute ) ;
        var p : AttributeValuePair<AttributeValue> = pairMap.get( a ) ;
        Assert.assert( p != null ) ;
        var pt : AttributeValuePair<ValueType> = cast(p) ;
        return pt.value ;
    }
    
    public function set<ValueType : AttributeValue>( attribute : Attribute<ValueType>, newValue : ValueType ) {
        var a : Attribute<AttributeValue> = cast( attribute ) ;
        var p : AttributeValuePair<AttributeValue> = pairMap.get( a ) ;
        Assert.assert( p != null ) ;
        var pt : AttributeValuePair<ValueType> = cast( p ) ;
        pt.value = newValue ;
    }
    public function has<ValueType : AttributeValue>( attribute : Attribute<ValueType> ) : Bool {
        var a : Attribute<AttributeValue> = cast( attribute ) ;
        return pairMap.exists( a ) ;
    }
}