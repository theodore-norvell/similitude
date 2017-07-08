package com.mun.type;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
/**
* typedef LinkAndComponentAndEndpointArray = {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
    var endpointArray:Array<Endpoint>;
}
**/
class LinkAndComponentAndEndpointArray {
    @:isVar var linkArray(get, set):Array<Link>;
    @:isVar var componentArray(get, set):Array<Component>;
    @:isVar var endponentArray(get, set):Array<Endpoint>;
    public function new() {
        this.linkArray = new Array<Link>();
        this.componentArray = new Array<Component>();
        this.endponentArray = new Array<Endpoint>();
    }

    public function addLink(link:Link){
        linkArray.push(link);
    }

    public function addComponent(component:Component){
        componentArray.push(component);
    }

    public function addEndpoint(endpoint:Endpoint){
        endponentArray.push(endpoint);
    }

    public function removeLink(link:Link){
        linkArray.remove(link);
    }

    public function removeComponent(component:Component){
        componentArray.remove(component);
    }

    public function removeEndpoint(endpoint:Endpoint){
        endponentArray.remove(endpoint);
    }

    public function get_linkArray():Array<Link> {
        return linkArray;
    }

    public function set_linkArray(value:Array<Link>) {
        return this.linkArray = value;
    }

    public function get_componentArray():Array<Component> {
        return componentArray;
    }

    public function set_componentArray(value:Array<Component>) {
        return this.componentArray = value;
    }

    public function get_endponentArray():Array<Endpoint> {
        return endponentArray;
    }

    public function set_endponentArray(value:Array<Endpoint>) {
        return this.endponentArray = value;
    }

    public function clean(){
        this.linkArray.splice(0,linkArray.length);
        this.componentArray.splice(0,linkArray.length);
        this.endponentArray.splice(0,linkArray.length);
    }

    public function isEmpty():Bool{
        if(linkArray == null || linkArray.length == 0){
            return true;
        }else if(componentArray == null || componentArray.length == 0){
            return true;
        }else if(endponentArray == null || endponentArray.length == 0){
            return true;
        }else{
            return false;
        }
    }
}
