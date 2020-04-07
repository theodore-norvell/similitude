package model.attribute;

class AttributeValuePair< ValueType : AttributeValue> {
    public var attribute( default, null ) : Attribute<ValueType> ;
    public var value( default, default ) : ValueType ;

    public function new( attribute : Attribute<ValueType> ) {
        this.attribute = attribute ;
        this.value = attribute.defaultValue ;
    }
}