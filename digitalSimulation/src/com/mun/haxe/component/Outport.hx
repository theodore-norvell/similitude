package com.mun.haxe.component;
import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.enumeration.ValueLogic;
class Outport implements Port{
    @:isVar var xPosition(get, set):Float;
    @:isVar var yPosition(get, set):Float;
    @:isVar var portDescription(get, null):IOTYPE;
    @:isVar var value(get, set):ValueLogic;
    @:isVar var sequence(get, set):Int;

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

    public function set_value(value:ValueLogic):ValueLogic {
        this.value = value;
    }

    public function get_portDescription():IOTYPE {
        return portDescription;
    }

    function set_portDescription(value:IOTYPE) {
        return this.portDescription = value;
    }

    function set_sequence(sequence : Int):Int {
        this.sequence = sequence;
    }

    function get_sequence():Int {
        return sequence;
    }
    public function new(xPosition : Float, yPosition : Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        portDescription = IOTYPE.OUTPUT;
    }
}
