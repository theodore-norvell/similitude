package model.gates;

import model.attribute.Attribute;
import type.LinkAndComponentAndEndpointAndPortArray;
import type.HitObject;
import model.component.CircuitDiagramI;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import type.Coordinate;
import type.WorldPoint;
import model.drawingInterface.DrawingAdapterI;
import model.component.Component;
import model.component.Port;
import model.enumeration.ORIENTATION;
/**
* Component Kind
* @author wanhui
**/
interface ComponentKind {

    public function getname():String;

    // TODO: I don't like that this returns an array.  Is there a better interface?
    public function getAttr():Array<Attribute>;

    /** create ports for each gate.
    *  Because box can identify the 4 corner of the component, so we can use a,b,c,d to identify the position of the component
    *  @param xPosition : x position
    *  @param yPosition : y position
    *  @param height : height
    *  @param width : width
    *  @param orientation : direction
    *  @param [Optional] inportNum : the number of inports in this gates, initial value is 2
    *  @return the array of the created ports
    **/
    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port>;

    public function checkInnerCircuitDiagramPortsChange():Bool;

    /**
    * add an inport
     * @return the created ports
    **/
    public function addInPort():Port;

    public function addOutPort():Port;

    /**
    * update all of the position of ports in inportArray
     * @param portArray
     * @param xPosition : x position
    *  @param yPosition : y position
    *  @param height : height
    *  @param width : width
    *  @param orientation : direction
    *  @return the array of the updated ports
    **/
    public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port>;

    /**
    * update all of the position of ports in in outportArray
     * @param portArray
     * @param xPosition : x position
    *  @param yPosition : y position
    *  @param height : height
    *  @param width : width
    *  @param orientation : direction
    *  @return the array of the updated ports
    **/
    public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port>;

    /**
    * draw this componentkind
     * @param component
     * @param drawingAdapter
    **/
    public function drawComponent(drawingAdapter:DrawingAdapterI, hightLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray):Void;

    /**
    * get component sequence
    * TODO Get rid of this.
    **/
    public function get_sequence():Int;

    /**
    * set component sequence
    * TODO Get rid of this.
    **/
    public function set_sequence(value:Int):Int;

    /**
    * get the component which belongs to this kind.
    * TODO Get rid of this.
    **/
    public function get_component():Component;

    /**
    * set the componentKind belongs to which component
    * TODO Get rid of this.
    **/
    public function set_component(value:Component):Void;

    /**
    * find the hit list
    **/
    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>;

    /**
    * find world point
    **/
    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>;

    /**
    * this function just use for compound component
    * TODO Get rid of this.
    **/
    public function getInnerCircuitDiagram():CircuitDiagramI;

    public function setname(s:String):Void;
}
