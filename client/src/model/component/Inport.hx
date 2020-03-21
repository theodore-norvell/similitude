package model.component;

import model.enumeration.IOTYPE;
class Inport implements Port {

    var xPosition:Float;
    var yPosition:Float;
    var portDescription:IOTYPE;
    var sequence:Int = -1;

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

    public function get_portDescription():IOTYPE {
        return this.portDescription;
    }

    public function set_portDescription(value:IOTYPE):Void {
        this.portDescription = value;
    }

    public function get_sequence():Int {
        return this.sequence;
    }

    public function set_sequence(sequence:Int):Void {
        this.sequence = sequence;
    }

    public function new(?xPosition:Float, ?yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        portDescription = IOTYPE.INPUT;
    }

    public function createJSon():String{
        var jsonString:String = "{ \"xPosition\": \"" + this.xPosition + "\",";
        jsonString += "\"yPosition\": \"" + this.yPosition + "\",";
        jsonString += "\"portDescription\": \"" + this.portDescription + "\",";
        jsonString += "\"sequence\": \"" + this.sequence + "\"";
        jsonString += "}";
        return jsonString;
    }
}
