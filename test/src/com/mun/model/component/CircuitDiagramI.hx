package com.mun.model.component;
import com.mun.model.enumeration.Orientation;
/**
* interface for CicuitDiagram
**/
interface CircuitDiagramI {
    /**
    * @:getter component array from the circuit diagram
     * @return the iterator
    **/
    public function get_componentArray():Array<Component>;

    /**
    * @:setter the componentArray
    **/
    public function set_componentArray(value:Array<Component>):Void;

    /**
    * @:getter link array from the circuit diagram
     * @return the iterator
    **/
    public function get_linkArray():Array<Link>;

    /**
    * @:setter the link array
    **/
    public function set_linkArray(value:Array<Link>):Void;

    /**
    * @:getter the name of the circuit diagram
    * @return the name
    **/
    public function get_name():String;

    /**
    * @:setter the name of the circuit diagram
    **/
    public function set_name(value:String):Void;

    /**
    * add one link
    **/
    public function addLink(link:Link):Void;

    /**
    * add one component
    **/
    public function addComponent(component:Component):Void;

    /**
    * remove one link
    **/
    public function removeLink(link:Link):Void;

    /**
    * remove one component
    **/
    public function removeComponent(component:Component):Void;

    /**
    * clear the copy stack
    **/
    public function clearCopyStack():Void;

    /**
    * push link to the copy stack
    **/
    public function pushLinkToCopyStack(link:Link):Void;

    /**
    * push component to the copy stack
    **/
    public function pushComponentToCopyStack(component:Component):Void;

    /**
    * set new orientation for one component
    **/
    public function setNewOirentation(component:Component, newOrientation:Orientation):Void;

    /**
    * delete one link
    **/
    public function deleteLink(link:Link):Void;

    /**
    * delete one component
    **/
    public function deleteComponent(component:Component):Void;

    /**
    * update one component
    **/
    public function updateComponent(component:Component):Void;

    /**
    * link need to update the enpdoint position by itself
    **/
    public function linkArraySelfUpdate():Void;

    /**
    * set name for component
    **/
    public function componentSetName(component:Component, name:String):Void;
}
