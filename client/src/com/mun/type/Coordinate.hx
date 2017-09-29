package com.mun.type;
/**
* typedef Coordinate = {
*    var xPosition:Float;
*    var yPosition:Float;
*    }
**/
class Coordinate {
    @:isVar var xPosition(get, set):Float;
    @:isVar var yPosition(get, set):Float;

    public function new(xPosition:Float, yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
    }

    public function get_xPosition():Float {
        return xPosition;
    }

    public function set_xPosition(value:Float) {
        return this.xPosition = value;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function set_yPosition(value:Float) {
        return this.yPosition = value;
    }
}
