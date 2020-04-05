package com.mun.type;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Port;
import com.mun.model.component.Link;
import com.mun.model.component.Component;
import com.mun.model.component.CircuitDiagramI;
class HitObject {
    var circuitDiagram:CircuitDiagramI;
    var component:Component;
    var link:Link;
    var port:Port;
    var endpoint:Endpoint;

    public function new() {

    }

    public function hitNothing():Bool{
        if(component == null && link == null && port == null && endpoint == null){
            return true;
        }else{
            return false;
        }
    }

    public function get_circuitDiagram():CircuitDiagramI {
        return circuitDiagram;
    }

    public function set_circuitDiagram(value:CircuitDiagramI) {
        return this.circuitDiagram = value;
    }

    public function get_component():Component {
        return component;
    }

    public function set_component(value:Component) {
        return this.component = value;
    }

    public function get_link():Link {
        return link;
    }

    public function set_link(value:Link) {
        return this.link = value;
    }

    public function get_port():Port {
        return port;
    }

    public function set_port(value:Port) {
        return this.port = value;
    }

    public function get_endpoint():Endpoint {
        return endpoint;
    }

    public function set_endpoint(value:Endpoint) {
        return this.endpoint = value;
    }
}
