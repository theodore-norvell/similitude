package model.attribute;

import assertions.Assert ;

class AttributeList {
    var list = new Array< Attribute<AttributeValue> >() ;

    public function new() {
    }

    public function add<T : AttributeValue>( attr : Attribute<T> ) : Void {
        var attrErased : Attribute<AttributeValue> = cast( attr ) ;
        Assert.assert( list.indexOf( attrErased ) == -1 ) ;
        list.push( attrErased ) ; 
    }

    public function iterator() : Iterator< Attribute<AttributeValue> > {
        return list.iterator() ;
    }
}