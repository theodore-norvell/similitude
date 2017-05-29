package com.mun.model.component;

import com.mun.controller.command.Stack;
import com.mun.model.enumeration.Orientation;

class CircuitDiagram implements CircuitDiagramI{
    var componentArray:Array<Component> = new Array<Component>();
    var linkArray:Array<Link> = new Array<Link>();
    var name:String;//the name of this circuit diagram
    var copyStack:Stack;

    public function new() {
        copyStack = new Stack();
    }

    public function get_componentArray():Array<Component>{
        return componentArray;
    }

    public function set_componentArray(value:Array<Component>):Void{
        this.componentArray = value;
    }

    public function get_linkArray():Array<Link>{
        return linkArray;
    }

    public function set_linkArray(value:Array<Link>):Void{
        this.linkArray = value;
    }

    public function get_name():String {
        return name;
    }

    public function set_name(value:String):Void{
        this.name = value;
    }

    public function addLink(link:Link):Void {
        linkArray.push(link);
    }

    public function addComponent(component:Component):Void {
        componentArray.push(component);
    }

    public function removeLink(link:Link):Void {
        linkArray.remove(link);
    }

    public function removeComponent(component:Component):Void {
        componentArray.remove(component);
    }

    public function clearCopyStack():Void{
        copyStack.clearStack();
    }

    public function pushLinkToCopyStack(link:Link):Void{
        copyStack.pushLink(link);
    }

    public function pushComponentToCopyStack(component:Component):Void{
        copyStack.pushComponent(component);
    }

    public function SetNewOirentation(component:Component, newOrientation:Orientation):Void{
        for (i in 0...componentArray.length) {
            if (component == componentArray[i]) {
                componentArray[i].set_orientation(newOrientation);
            }
        }
    }

    public function deleteLink(link:Link):Void{
        linkArray.remove(link);
    }

    public function deleteComponent(component:Component):Void{
        componentArray.remove(component);
        //delete port setted in the link
        for(i in 0...component.get_inportArray().length){
            for(j in 0...linkArray.length){
                if(component.get_inportArray()[i] == linkArray[j].get_leftEndpoint().get_port()){
                    linkArray[j].get_leftEndpoint().set_port(null);
                }

                if(component.get_inportArray()[i] == linkArray[j].get_rightEndpoint().get_port()){
                    linkArray[j].get_rightEndpoint().set_port(null);
                }

            }
        }
        //
        for(i in 0...component.get_outportArray().length){
            for(j in 0...linkArray.length){
                if(component.get_outportArray()[i] == linkArray[j].get_leftEndpoint().get_port()){
                    linkArray[j].get_leftEndpoint().set_port(null);
                }

                if(component.get_outportArray()[i] == linkArray[j].get_rightEndpoint().get_port()){
                    linkArray[j].get_rightEndpoint().set_port(null);
                }

            }
        }
    }

    public function updateComponent(component:Component):Void{
        componentArray[componentArray.indexOf(component)] = component;
    }

    /**
    * because component may update the port position, so the link should update all of the port connect to the component port
    **/
    public function linkArraySelfUpdate():Void{
        for(i in 0...linkArray.length){
            linkArray[i].get_leftEndpoint().updatePosition();
            linkArray[i].get_rightEndpoint().updatePosition();
        }
    }
}
