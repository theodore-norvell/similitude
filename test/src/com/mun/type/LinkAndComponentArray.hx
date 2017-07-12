package com.mun.type;

/**
* typedef LinkAndComponentArray = {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
}
**/
import com.mun.model.component.Component;
import com.mun.model.component.Link;
class LinkAndComponentArray {
    @:isVar var linkArray(get, set):Array<Link>;
    @:isVar var componentArray(get, set):Array<Component>;
    public function new() {
        linkArray = new Array<Link>();
        componentArray = new Array<Component>();
    }

    public function addLink(link:Link){
        linkArray.push(link);
    }

    public function addComponent(component:Component){
        componentArray.push(component);
    }

    public function removeLink(link:Link){
        linkArray.remove(link);
    }

    public function removeComponent(component:Component){
        componentArray.remove(component);
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

    public function clean(){
        this.linkArray.splice(0,linkArray.length);
        this.componentArray.splice(0,componentArray.length);
    }

    public function isEmpty():Bool{
        if(linkArray == null || linkArray.length == 0){
            return true;
        }else if(componentArray == null || componentArray.length == 0){
            return true;
        }else{
            return false;
        }
    }
}
