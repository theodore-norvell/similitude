package model.component;

import model.enumeration.IOTYPE;

class Outport implements Port {
    var xPosition:Float;
    var yPosition:Float;
    var portDescription:IOTYPE;
    var sequence:Int;

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
        return portDescription;
    }

    public function set_portDescription(value:IOTYPE):Void {
        this.portDescription = value;
    }

    public function get_sequence():Int {
        return sequence;
    }

    public function set_sequence(sequence:Int):Void {
        this.sequence = sequence;
    }

    public function new(?xPosition:Float, ?yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        portDescription = IOTYPE.OUTPUT;
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
