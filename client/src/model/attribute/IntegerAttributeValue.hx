package model.attribute;
import model.enumeration.Orientation;

class IntegerAttributeValue implements AttributeValue {

    static var type = new AttributeType("IntegerAttributeValue") ;
    var value:Int ;
    public function new( value : Int ) {
        this.value = value;
    }

    public function getValue() : Int {
        return this.value ;
    }

    public function getType() : AttributeType {
        return type ;
    }
}
