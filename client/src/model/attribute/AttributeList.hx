package model.attribute;

import assertions.Assert ;

class AttributeList {
    var list = new Array< AttributeUntyped >() ;

    public function new() {
    }

    public function add( attr : AttributeUntyped ) : Void {
        Assert.assert( list.indexOf( attr ) == -1 ) ;
        list.push( attr ) ; 
    }

    public function iterator() : Iterator< AttributeUntyped > {
        return list.iterator() ;
    }
}