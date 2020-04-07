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
import model.enumeration.Orientation;
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
    * TODO replace this method with one that uses a SelectionModel.
    * TODO Get rid of the HitObject class.
    **/
    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>;

    /**
    * Find all coordinates a point corresponds to.
    * This can be used when there is a mouse click on a circuit. The view
    * would transform the view coordinate to a world coordinate and then call
    * this methods.
    * 
    * Normally this  method just returns a world point that consistst of this diagram
    * and the input coordinate. However when a point is inside a (white box) compound component, the
    * point also refers to a coordinate within that compound component.  So in that case
    * there are two points (at least) that could have been intended by the mouse click.
    * And there could be more beneath that.
    * 
    * When mode is POINT_MODE.ONE, only one world point is returned.
    * 
    * When mode is POINT_MODE.PATH, all the world points are returned. In no particular order.
    **/
    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>;

}
