package model.attribute;
import model.enumeration.ORIENTATION;

class OrientationAttributeValue implements AttributeValue<OrientationAttributeType> {
    var orientation:ORIENTATION;
    public function new(or:Orientation) {
        orientation=or;
    }

    public function getOrientation() : Orientation{
        return orientation ;
    }

    public function getType() : AttrType {
        return attrType ;
    }
}
