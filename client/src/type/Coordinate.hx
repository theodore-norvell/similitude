package type;
/**
* typedef Coordinate = {
*    var xPosition:Float;
*    var yPosition:Float;
*    }
**/
class Coordinate {
    var xPosition:Float;
    var yPosition:Float;

    public function new(xPosition:Float, yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
    }

    public function get_xPosition():Float {
        return xPosition;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function plus( other : Coordinate ) {
        return new Coordinate( this.xPosition + other.xPosition,
                               this.yPosition + other.yPosition ) ;
    }
}
