package com.mun.haxe.component;
class CircuitDiagram {
    @:isVar var componentArray(get, set):Array<Component>;
    @:isVar var linkArray(get, set):Array<Link>;
    @:isVar var name(get, set):String;//the name of this circuit diagram

    public function new() {

    }

    function get_componentArray():Array<Component> {
        return componentArray;
    }

    function set_componentArray(value:Array<Component>) {
        return this.componentArray = value;
    }

    function get_linkArray():Array<Link> {
        return linkArray;
    }

    function set_linkArray(value:Array<Link>) {
        return this.linkArray = value;
    }

    function get_name():String {
        return name;
    }

    function set_name(value:String) {
        return this.name = value;
    }

}
