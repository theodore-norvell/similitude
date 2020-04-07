package model.attribute;
import model.enumeration.Orientation;

class OrientationAttributeValue implements AttributeValue {
    var orientation:ORIENTATION;
    public function new( orientation: Orientation ) {
        this.orientation = orientation;
    }

    public function getOrientation() : Orientation{
        return orientation ;
    }

    public function getType() : AttrType {
        return attrType ;
    }
}
