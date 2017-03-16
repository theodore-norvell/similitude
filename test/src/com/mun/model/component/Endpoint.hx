package com.mun.model.component;


/**
 * Every link should have two endpoints
 * @author wanhui
 *
 */
class Endpoint {
    var xPosition:Float;
    var yPosition:Float;
    var port:Port;

    /**
	 * constructor for the endpont
	 * @param xPosition x position
	 * @param yPosition y position
	 */
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

    public function get_port():Port {
        return port;
    }

    public function set_xPosition(value:Float) {
        return this.xPosition = value;
    }

    public function set_yPosition(value:Float) {
        return this.yPosition = value;
    }

    public function set_port(value:Port) {
        return this.port = value;
    }


}
