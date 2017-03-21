package com.mun.haxe.component;

/**
 * Link consist of two endpoints
 * @author wanhui
 *
 */
class Link {
    @:isVar var leftEndpoint(get, set):Endpoint;
    @:isVar var rightEndpoint(get, set):Endpoint;

    public function new(leftEndpoint : Endpoint, rightEndpoint : Endpoint) {
        this.leftEndpoint = leftEndpoint;
        this.rightEndpoint = rightEndpoint;
    }

    function get_leftEndpoint():Endpoint {
        return leftEndpoint;
    }

    function set_leftEndpoint(value:Endpoint) {
        return this.leftEndpoint = value;
    }

    function get_rightEndpoint():Endpoint {
        return rightEndpoint;
    }

    function set_rightEndpoint(value:Endpoint) {
        return this.rightEndpoint = value;
    }

}
