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
	
	public static function getTypeForClass() : String {
		return "StringAttributeValue";
	}

    public function equals( other : AttributeValue ) : Bool {
        if( other.getType() != type ) return false ;
        else {
            var otherStrAV : StringAttributeValue = cast(other,StringAttributeValue) ;
            return otherStrAV.value == this.value ;
        }
    }
}
