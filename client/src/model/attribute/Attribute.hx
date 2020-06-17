package model.attribute;

/** Attributes are keys with which to get attribute values.
 * Each attribute has a name, a type, and a defaultValue.
 * Each conceptual attribute should be represented by one (and only one)
 * attribute object.  (So pointer equality may be used to compare attributes.)
 * **/
class Attribute< T : AttributeValue > implements AttributeUntyped {
    var defaultValue : T ;
    var type : AttributeType ;

    var name : String ;

    public function new( name : String, defaultValue : T ) {
        this.name = name ;
        this.type = defaultValue.getType() ;
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
