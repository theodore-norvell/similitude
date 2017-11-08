package com.mun.model.gates;

import com.mun.model.attribute.Attribute;
import js.html.Attr;
import js.html.CanvasRenderingContext2D;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.type.HitObject;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.enumeration.MODE;
import com.mun.type.Coordinate;
import com.mun.type.WorldPoint;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.enumeration.ORIENTATION;
/**
* Component Kind
* @author wanhui
**/
interface ComponentKind {
    /**
    * get the least inport number for each of the component kind
     * @return the number of inport should be in this component kind at least
    **/
    public function getLeastInportNumber():Int;

    public function getname():String;

    public function getDelay():Int;

    public function setDelay(value:Int):Int;

    public function getAttr():Array<Attribute>;


    /**
	 * Every gate should have a algorithm to define the output value.
	 * this method is to calculate the gate value.
	 * @param DrawAND type to manage those input and output
	 * @return DrawAND type describe those input and output
	 */
    public function algorithm(portArray:Array<Port>):Array<Port>;

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
    public function drawComponent(drawingAdapter:DrawingAdapterI, hightLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, ?context:CanvasRenderingContext2D):Void;

    /**
    * get component sequence
    **/
    public function get_sequence():Int;

    /**
    * set component sequence
    **/
    public function set_sequence(value:Int):Int;

    /**
    * get the componentKind belongs to which component
    **/
    public function get_component():Component;

    /**
    * set the componentKind belongs to which component
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
    **/
    public function getInnerCircuitDiagram():CircuitDiagramI;

    /**
    * create xml file
    **/
    public function createJSon():String;
}
