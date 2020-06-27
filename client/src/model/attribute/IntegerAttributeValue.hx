package model.attribute;

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
	
	public static function getTypeForClass() : String {
		return "IntegerAttributeValue";
	}

    public function equals( other : AttributeValue ) : Bool {
        if( other.getType() != type ) return false ;
        else {
            var otherIntAV : IntegerAttributeValue = cast(other,IntegerAttributeValue) ;
            return otherIntAV.value == this.value ;
        }
    }
}
