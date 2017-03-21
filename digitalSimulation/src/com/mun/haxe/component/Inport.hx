package com.mun.haxe.component;
import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.enumeration.ValueLogic;
class Inport implements Port{

    @:isVar var xPosition(get, set):Float;
    @:isVar var yPosition(get, set):Float;
    @:isVar var portDescription(get, null):IOTYPE;
    @:isVar var value(get, set):ValueLogic;
    @:isVar var sequence(get, set):Int;//init is 1, identify the sequence of the port for gate

    function get_xPosition():Float {
        return xPosition;
    }

    function set_xPosition(value:Float) {
        return this.xPosition = value;
    }

    function get_yPosition():Float {
        return yPosition;
    }

    function set_yPosition(value:Float) {
        return this.yPosition = value;
    }

    function get_value():ValueLogic {
        return value;
    }

    function set_value(value:ValueLogic) {
        return this.value = value;
    }

    function get_portDescription():IOTYPE {
        return portDescription;
    }

    function get_sequence():Int {
        return sequence;
    }

    function set_sequence(value:Int) {
        return this.sequence = value;
    }

    public function new(xPosition : Float, yPosition : Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        portDescription = IOTYPE.INPUT;
    }
}
