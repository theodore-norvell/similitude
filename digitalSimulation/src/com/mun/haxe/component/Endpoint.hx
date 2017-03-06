package com.mun.haxe.component;

/**
 * Every link should have two endpoints
 * @author wanhui
 *
 */
class Endpoint {
    @:isVar var xPosition(get, null):Float;
    @:isVar var yPosition(get, null):Float;
    @:isVar var port(get, null):Port;

    /**
	 * constructor for the endpont
	 * @param xPosition x position
	 * @param yPosition y position
	 */
    public function new(xPosition : Float, yPosition : Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
    }

    function get_xPosition():Float {
        return xPosition;
    }

    function get_yPosition():Float {
        return yPosition;
    }

    function get_port():Port {
        return port;
    }

    function set_xPosition(value:Float) {
        return this.xPosition = value;
    }

    function set_yPosition(value:Float) {
        return this.yPosition = value;
    }

    function set_port(value:Port) {
        return this.port = value;
    }


}
