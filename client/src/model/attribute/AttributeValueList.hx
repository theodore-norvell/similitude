package model.attribute;

import assertions.Assert ;


private class AttributeValuePair {
    public var attribute( default, null ) : AttributeUntyped ;
    public var value( default, default ) : AttributeValue ;

    public function new( attribute : AttributeUntyped ) {
        this.attribute = attribute ;
        this.value = attribute.getDefaultValue() ;
    }
}
/**
 *  An map from Attributes to AttributeValues.
 */
class AttributeValueList {

    // Invariant: forall a : AttributeUntyped | pairMap.get( a ) != null .
    //                            pairMap.get( a ).attribute == a
    //                        and pairMap.get( a ).value.getType() == a.getType()
 
    var pairMap : Map<AttributeUntyped, AttributeValuePair> ;

    public function new( attributes : Iterator<AttributeUntyped> ) {
        pairMap = new Map<AttributeUntyped, AttributeValuePair>() ;
        for( attr in attributes ) {
            var p = new AttributeValuePair( attr ) ;
            pairMap.set( attr, p ) ;
        }
    }
    public function getAttributes( ) : Iterator< AttributeUntyped > {
        return pairMap.keys() ;
    }
    public function get<T : AttributeValue>( attribute : Attribute<T> ) : T {
        return cast( getUntyped( attribute ) ) ;
    }
    public function getUntyped( attribute : AttributeUntyped ) : AttributeValue {
        var p : AttributeValuePair = pairMap.get( attribute ) ;
        Assert.assert( p != null ) ;
        return p.value ;
    }
    
    public function set<T : AttributeValue>( attribute : Attribute<T>, newValue : T ) {
        setUntyped( attribute, newValue ) ;
    }
    public function setUntyped( attribute : AttributeUntyped, newValue : AttributeValue ) {
        var p : AttributeValuePair = pairMap.get( attribute ) ;
        Assert.assert( p != null ) ;
        Assert.assert( newValue.getType() == attribute.getType() ) ;
        p.value = newValue ;
    }
    public function has( attribute : AttributeUntyped ) : Bool {
        return pairMap.exists( attribute ) ;
    }
}