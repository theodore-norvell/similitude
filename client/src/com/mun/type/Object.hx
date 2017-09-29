package com.mun.type;

import com.mun.model.component.Port;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
/**
* typedef Object = {
    var link:Link;
    var component:Component;
    var endPoint:Endpoint;
    var port:Port;
}
**/
class Object {
    @:isVar var link(get, set):Link;
    @:isVar var component(get, set):Component;
    @:isVar var endPoint(get, set):Endpoint;
    @:isVar var port(get, set):Port;

    public function new() {

    }

    public function get_link():Link {
        return link;
    }

    public function set_link(value:Link) {
        return this.link = value;
    }

    public function get_component():Component {
        return component;
    }

    public function set_component(value:Component) {
        return this.component = value;
    }

    public function get_endPoint():Endpoint {
        return endPoint;
    }

    public function set_endPoint(value:Endpoint) {
        return this.endPoint = value;
    }

    public function get_port():Port {
        return port;
    }

    public function set_port(value:Port) {
        return this.port = value;
    }

    public function isEmpty(){
        if(link == null || component == null || endPoint == null || port == null){
            return true;
        }else{
            return false;
        }
    }
}
