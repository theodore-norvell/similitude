package com.mun.model.component;

import com.mun.controller.command.Stack;
import com.mun.model.enumeration.Orientation;
class CircuitDiagram {
    var componentArray:Array<Component> = new Array<Component>();
    var linkArray:Array<Link> = new Array<Link>();
    var name:String;//the name of this circuit diagram
    var copyStack:Stack;

    public function new() {
        copyStack = new Stack();
    }

    public function get_componentArray():Array<Component> {
        return componentArray;
    }

    public function set_componentArray(value:Array<Component>) {
        return this.componentArray = value;
    }

    public function get_linkArray():Array<Link> {
        return linkArray;
    }

    public function set_linkArray(value:Array<Link>) {
        return this.linkArray = value;
    }

    public function get_name():String {
        return name;
    }

    public function set_name(value:String) {
        return this.name = value;
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

    public function clearCopyStack() {
        copyStack.clearStack();
    }

    public function pushLinkToCopyStack(link:Link) {
        copyStack.pushLink(link);
    }

    public function pushComponentToCopyStack(component:Component) {
        copyStack.pushComponent(component);
    }

    public function SetNewOirentation(component:Component, newOrientation:Orientation) {
        for (i in 0...componentArray.length) {
            if (component == componentArray[i]) {
                componentArray[i].set_orientation(newOrientation);
            }
        }
    }

    public function deleteLink(link:Link) {
        linkArray.remove(link);
    }

    public function deleteComponent(component:Component) {
        componentArray.remove(component);
    }

    public function updateComponent(component:Component, index:Int){
        componentArray[index] = component;
    }
}
