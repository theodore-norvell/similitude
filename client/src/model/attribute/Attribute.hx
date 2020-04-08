package model.attribute;

class Attribute< ValueType : AttributeValue >  {
    var defaultValue : ValueType ;
    var type : AttributeType ;

    var name : String ;

    public function new( name : String, type : AttributeType, defaultValue : ValueType ) {
        this.name = name ;
        this.type = type ;
        this.defaultValue = defaultValue ;
    }

    public function getDefaultValue() : ValueType {
        return defaultValue ;
    }

    public function getType() : AttributeType {
        return type ;
    }

    /**Equality for attributes**/ 
    public function is< T : AttributeValue >( other : Attribute<T> ) : Bool {
        var me : Attribute<AttributeValue> = cast( this ) ;
        var they : Attribute<AttributeValue> = cast( other ) ;
        return me == they ;
    }
}
