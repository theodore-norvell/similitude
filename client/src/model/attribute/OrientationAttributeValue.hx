package model.attribute;
import model.enumeration.Orientation;

class OrientationAttributeValue implements AttributeValue {

    static var type = new AttributeType("OrientationAttributeValue") ;
    var orientation:Orientation;
    public function new( orientation: Orientation ) {
        this.orientation = orientation;
    }

    public function getOrientation() : Orientation{
        return orientation ;
    }

    public function getType() : AttributeType {
        return type ;
    }
    public function equals( other : AttributeValue ) : Bool {
        if( other.getType() != type ) return false ;
        else {
            var otherOAV : OrientationAttributeValue = cast(other,OrientationAttributeValue) ;
            return otherOAV.orientation == this.orientation ;
        }
    }
}
