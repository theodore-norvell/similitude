package model.attribute;

class Attribute< T : AttributeValue > implements AttributeUntyped {
    var defaultValue : T ;
    var type : AttributeType ;

    var name : String ;

    public function new( name : String, type : AttributeType, defaultValue : T ) {
        this.name = name ;
        this.type = type ;
        this.defaultValue = defaultValue ;
    }

    public function getDefaultValue() : T {
        return defaultValue ;
    }

    public function getType() : AttributeType {
        return type ;
    }

    public function getName() : String {
        return name ;
    }
}
