package model.component;
//import js.html.CanvasRenderingContext2D;
import haxe.ds.GenericStack;
import type.HitObject;
import model.enumeration.POINT_MODE;
import type.Coordinate;
import type.WorldPoint;
import model.enumeration.MODE;
import model.selectionModel.SelectionModel ;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.ORIENTATION;
/**
* interface for CicuitDiagram
**/
interface CircuitDiagramI {
    /**
    * @:getter component array from the circuit diagram
     * @return the iterator
    **/
    public function get_componentIterator():Iterator<Component>;

    /**
    * @:getter link array from the circuit diagram
     * @return the iterator
    **/
    public function get_linkIterator():Iterator<Link>;

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
    * delete one link
    **/
    public function deleteLink(link:Link):Void;

    /**
    * delete one component
    **/
    public function deleteComponent(component:Component):Void;

    /**
    * set name for component
    **/
    public function componentSetName(component:Component, name:String):Void;

    /**
    * update the size of this diagram
    * note: the size of this diagram changed only happens in two suitutions
    *       1. add a component
    *       2. move a component (significant slow down the performance)
    *            because there is no way to track the change for every component, so make this function public.
    **/
    public function updateBoundingBox():Void;

    /**
    * get the width of this diagram
    **/
    public function get_diagramWidth():Float;

    /**
    * get the height of this diagram
    **/
    public function get_diagramHeight():Float;

    /**
    * get min x
    **/
    public function get_xMin():Float;

    /**
    * get min y
    **/
    public function get_yMin():Float;

    /**
    * get x max
    **/
    public function get_xMax():Float;

    /**
    * get y max
    **/
    public function get_yMax():Float;

    public function get_centre():Coordinate;

    /**
    * draw the circuit diagram itself
    **/
    public function draw( drawingAdapter:DrawingAdapterI,
                          selected: SelectionModel ):Void;

    /**
    * find the hit list
    **/
    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>;

    /**
    * find the world points
    **/
    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>;

    /**
    * is this circuitdiagram has nothing?
    **/
    public function isEmpty():Bool;
}
