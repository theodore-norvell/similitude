package com.mun.model.component;
import com.mun.controller.command.CommandManager;
import com.mun.model.enumeration.Orientation;
/**
* interface for CicuitDiagram
**/
interface CircuitDiagramI {
    /**
    * @@:getter get command manager
    **/
    public function get_commandManager():CommandManager;

    /**
    * @@:setter set command manager
    **/
    public function set_commandManager(value:CommandManager):Void;

    /**
    * @:getter component array from the circuit diagram
     * @return the iterator
    **/
    public function get_componentIterator():Iterator<Component>;

    /**
    * reverse iterator for componenent array
    **/
    public function get_componentReverseIterator():Iterator<Component>;

    /**
    * reverse iterator for link array
    **/
    public function get_linkReverseIterator():Iterator<Link>;

    /**
    * @:getter link array from the circuit diagram
     * @return the iterator
    **/
    public function get_linkIterator():Iterator<Link>;

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
