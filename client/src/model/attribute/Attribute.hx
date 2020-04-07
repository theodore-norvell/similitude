package model.attribute;

class Attribute< ValueType : AttributeValue > {
    public var defaultValue( default, null ) : ValueType ;
    public var type( default, null )  : AttributeType ;

    var name : String ;

    public function new( name : String, type : AttributeType, defaultValue : ValueType ) {
        this.name = name ;
        this.type = type ;
        this.defaultValue = defaultValue ;
    }
}
