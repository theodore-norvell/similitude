package com.mun.controller.command;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
/**
* copy stack used to store the copy stuff
* @author wanhui
**/
class Stack {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;

    public function new() {
        linkArray = new Array<Link>();
        componentArray = new Array<Component>();
    }

    public function getLinkArray():Array<Link> {
        return linkArray;
    }

    public function getComponentArray():Array<Component> {
        return componentArray;
    }

    public function pushLink(link:Link) {
        linkArray.push(link);
    }

    public function pushComponent(component:Component) {
        componentArray.push(component);
    }

    public function clearStack() {
        linkArray = new Array<Link>();
        componentArray = new Array<Component>();
    }

    public function isStackEmpty():Bool{
        if(linkArray.length == 0 && componentArray.length == 0){
            return true;
        }else{
            return false;
        }
    }
}
