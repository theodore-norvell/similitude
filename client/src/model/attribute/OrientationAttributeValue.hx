package model.attribute;
import model.enumeration.Orientation;

class OrientationAttributeValue implements AttributeValue {
    var orientation:Orientation;
    public function new( orientation: Orientation ) {
        this.orientation = orientation;
    }

    public function getOrientation() : Orientation{
        return orientation ;
    }

    public function getType() : AttributeType {
        return OrientationAttributeType.singleton ;
    }
}
