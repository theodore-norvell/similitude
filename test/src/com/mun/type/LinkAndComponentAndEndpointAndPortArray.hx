package com.mun.type;
import com.mun.model.component.Link;
import com.mun.model.component.Component;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Port;
/**
* typedef LinkAndComponentAndEndpointAndPortArray = {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
    var endpointArray:Array<Endpoint>;
    var portArray:Array<Port>;
}
**/
class LinkAndComponentAndEndpointAndPortArray {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
    var endponentArray:Array<Endpoint>;
    var portArray:Array<Port>;
    public function new() {
        this.linkArray = new Array<Link>();
        this.componentArray = new Array<Component>();
        this.endponentArray = new Array<Endpoint>();
        this.portArray = new Array<Port>();
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

    public function addPort(port:Port){
        portArray.push(port);
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

    public function removePort(port:Port){
        portArray.remove(port);
    }

    public function get_linkIterator():Iterator<Link> {
        return linkArray.iterator();
    }

    public function get_componentIterator():Iterator<Component> {
        return componentArray.iterator();
    }

    public function get_endponentIterator():Iterator<Endpoint> {
        return endponentArray.iterator();
    }

    public function get_portIterator():Iterator<Port>{
        return portArray.iterator();
    }

    public function getLinkIteratorLength():Int{
        return linkArray.length;
    }

    public function getEndppointIteratorLength():Int{
        return endponentArray.length;
    }

    public function getComponentIteratorLength():Int{
        return componentArray.length;
    }

    public function getPortIteratorLength():Int{
        return portArray.length;
    }

    public function getComponentFromIndex(index:Int):Component{
        return componentArray[index];
    }

    public function getLinkFromIndex(index:Int):Link{
        return linkArray[index];
    }

    public function getEndpointFromIndex(index:Int):Endpoint{
        return endponentArray[index];
    }

    public function getPortFromIndex(index:Int):Port{
        return portArray[index];
    }

    public function clean(){
        this.linkArray.splice(0,linkArray.length);
        this.componentArray.splice(0,componentArray.length);
        this.endponentArray.splice(0,endponentArray.length);
        this.portArray.splice(0,portArray.length);
    }

    public function isEmpty():Bool{
        if(linkArray.length == 0){
            return true;
        }else if(componentArray.length == 0){
            return true;
        }else if(endponentArray.length == 0){
            return true;
        }else if(portArray.length == 0){
            return true;
        }else{
            return false;
        }
    }
}
