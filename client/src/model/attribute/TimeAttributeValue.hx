package model.attribute;
import model.enumeration.Orientation;
import type.TimeUnit ;

class TimeAttributeValue implements AttributeValue {

    static var type = new AttributeType("TimeAttributeValue") ;
    // Time values are in integer multiples of femto seconds.
    // Note that 
    // 10e-15  is 1 fs
    // 10e-12  is 1 ps
    // 10e-9   is 1 ns
    // 10e-6   is 1 μs
    // 10e-3   is 1 ms
    var value : haxe.Int64 ;

    var unit : TimeUnit ;
    public function new( value : haxe.Int64, unit : TimeUnit ) {
        this.unit = unit ;
        this.value = to_fs( value, unit );
    }

    static var aThousand = haxe.Int64.make( 0, 1000 ) ;
    static var aMillion = haxe.Int64.make( 0, 1000000 ) ;
    static var aBillion = aMillion * aThousand ;
    static var aTrillion = aBillion * aThousand ;
    static var aQuadrillion = aBillion * aMillion ;

    private function to_fs( value : haxe.Int64, unit : TimeUnit ) : haxe.Int64 {
        return switch( unit ) {
            case FEMPTO_SECOND: value  ;
            case PICO_SECOND:   value * aThousand ;
            case NANO_SECOND:   value * aMillion ;
            case MICRO_SECOND:  value * aBillion ;
            case MILI_SECOND:   value * aTrillion ;
            case SECOND:        value * aQuadrillion  ;
        } ;
    }

    private function from_fs( value : haxe.Int64, unit : TimeUnit ) : haxe.Int64 {
        return switch( unit ) {
            case FEMPTO_SECOND: value ;
            case PICO_SECOND:   value / aThousand ;
            case NANO_SECOND:   value / aMillion ;
            case MICRO_SECOND:  value / aBillion ;
            case MILI_SECOND:   value / aTrillion ;
            case SECOND:        value / aQuadrillion  ;
        } ;
    }

    public function getValue() : haxe.Int64 {
        return from_fs( value, unit ) ;
    }

    public function getValueIn( unit : TimeUnit ) : haxe.Int64 {
        return from_fs( value, unit ) ;
    }

    public function getUnit( ) : TimeUnit {
        return unit ;
    }

    public function getType() : AttributeType {
        return type ;
    }
	
	public static function getTypeForClass() : AttributeType {
		return type ;
	}

    public function toString() : String {
        var number = haxe.Int64.toStr( getValue() ) ;
        var unit = switch( unit ) {
            case FEMPTO_SECOND: "fs"  ;
            case PICO_SECOND:   "ps" ;
            case NANO_SECOND:   "ns" ;
            case MICRO_SECOND:  "µs" ;
            case MILI_SECOND:   "ms" ;
            case SECOND:        "s"  ;
        } ;
        return number + " " + unit ;
    }

    public function equals( other : AttributeValue ) : Bool {
        if( other.getType() != type ) return false ;
        else {
            var otherTimeAV : TimeAttributeValue = cast(other,TimeAttributeValue) ;
            return otherTimeAV.value == this.value && otherTimeAV.unit == this.unit ;
        }
    }
}
