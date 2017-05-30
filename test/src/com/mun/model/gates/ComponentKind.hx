package com.mun.model.gates;

import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.enumeration.Orientation;
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
    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, ?inportNum:Int):Array<Port>;

    /**
    * add an inport
     * @return the created ports
    **/
    public function addInPort():Port;

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
    public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>;

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
    public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>;

    /**
    * draw this componentkind
     * @param component
     * @param drawingAdapter
    **/
    public function drawComponent(component:Component, drawingAdapter:DrawingAdapterI, hightLight:Bool):Void;
}
