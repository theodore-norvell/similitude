package com.mun.model.component;

import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ValueLogic;
class Inport implements Port {

    var xPosition:Float;
    var yPosition:Float;
    var portDescription:IOTYPE;
    var value:ValueLogic;
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

    public function get_value():ValueLogic {
        return value;
    }

    public function set_value(value:ValueLogic):Void {
        this.value = value;
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
}
