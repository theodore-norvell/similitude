package model.attribute;

class StringAttributeValue implements AttributeValue {

    static var type = new AttributeType("StringAttributeValue") ;
    var value : String ;
    public function new( value : String ) {
        this.value = value;
    }

    public function getValue() : String {
        return this.value ;
    }

    public function getType() : AttributeType {
        return type ;
    }
}
