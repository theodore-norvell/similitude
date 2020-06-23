package model.attribute;
import model.enumeration.Orientation;

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
        this.unit = TimeUnit ;
        this.value = to_fs( value, unit );
    }

    private function to_fs( value : haxe.Int64, unit : TimeUnit ) : haxe.Int64 {
        return swtich( unit ) {
            case FEMPTO_SECOND: value  ;
            case PICO_SECOND:   value * haxe.Int64( 1000 ) ;
            case NANO_SECOND:   value * haxe.Int64( 1000000 ) ;
            case MICRO_SECOND:  value * haxe.Int64( 1000000000 ) ;
            case MILI_SECOND:   value * haxe.Int64( 1000000000000 ) ;
            case SECOND:        value * haxe.Int64( 1000000000000000 )  ;
        }
    }

    private function from_fs( value : haxe.Int64, unit : TimeUnit ) : haxe.Int64 {
        return swtich( unit ) {
            case FEMPTO_SECOND: value ;
            case PICO_SECOND:   value / haxe.Int64( 1000 ) ;
            case NANO_SECOND:   value / haxe.Int64( 1000000 ) ;
            case MICRO_SECOND:  value / haxe.Int64( 1000000000 ) ;
            case MILI_SECOND:   value / haxe.Int64( 1000000000000 ) ;
            case SECOND:        value / haxe.Int64( 1000000000000000 )  ;
        }
    }

    public function getValue() : haxe.Int64 {
        return from_fs( value, unit )
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
}
