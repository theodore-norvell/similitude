package model.component;


import model.enumeration.IOTYPE;
/**
 * Every gate should have port to access the logic value
 * @author wanhui
 *
 */
class Port {

    var xPosition:Float;
    var yPosition:Float;
    var sequence:Int = -1;
    var description : IOTYPE ;

    public function new(xPosition:Float, yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.description = IOTYPE.OUTPUT ; 
    }

    public function get_xPosition():Float {
        return xPosition;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function set_xPosition(xPosition:Float):Void {
        this.xPosition = xPosition;
    }

    public function set_yPosition(yPosition:Float):Void {
        this.yPosition = yPosition;
    }

    public function get_sequence():Int {
        return this.sequence;
    }

    public function set_sequence(sequence:Int):Void {
        this.sequence = sequence;
    }

    public function get_portDescription():IOTYPE {
        return this.description ;
    }

    public function set_portDescription(description:IOTYPE):Void {
        this.description = description;
    }
}