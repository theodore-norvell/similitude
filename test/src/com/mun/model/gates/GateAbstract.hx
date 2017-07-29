package com.mun.model.gates;
import com.mun.type.HitObject;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.component.Component;
import com.mun.model.enumeration.MODE;
import com.mun.type.Coordinate;
import com.mun.type.WorldPoint;
import com.mun.model.component.Inport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.global.Constant.*;
/**
* abstract class for gates
* @author wanhui
**/
class GateAbstract{
    var leastInportNum:Int;
    var sequence:Int;//use for input and output
    var component:Component;

    private function new(leastInportNum:Int) {
        this.leastInportNum = leastInportNum;

        sequence = -1;
    }

    public function get_component():Component {
        return component;
    }

    public function set_component(value:Component):Void {
        this.component = value;
    }

    public function getLeastInportNumber():Int {
        return this.leastInportNum;
    }

    public function addInPort():Port {
        return new Inport();
    }

    public function get_sequence():Int {
        return sequence;
    }

    public function set_sequence(value:Int) {
        return this.sequence = value;
    }

    public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port> {
        switch (orientation){
            case ORIENTATION.EAST : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2);
                    portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                }
            };
            case ORIENTATION.NORTH : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                    portArray[i].set_yPosition(yPosition + height / 2);
                }
            };
            case ORIENTATION.SOUTH : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                    portArray[i].set_yPosition(yPosition - height / 2);
                }
            };
            case ORIENTATION.WEST : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition + width / 2);
                    portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                }
            };
            default:{
                //do nothing
            }
        }
        return portArray;
    }

    public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port>{
        switch(orientation){
            case ORIENTATION.EAST : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition + width / 2);
                    portArray[i].set_yPosition(yPosition);
                }
            };
            case ORIENTATION.NORTH : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition);
                    portArray[i].set_yPosition(yPosition - height / 2);
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition);
                    portArray[i].set_yPosition(yPosition + height / 2);
                }
            };
            case ORIENTATION.WEST : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition - width / 2);
                    portArray[i].set_yPosition(yPosition);
                }
            };
            default:{
                //do nothing
            }
        }
        return portArray;
    }

    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();

        var component:Component = isInComponent(coordinate);
        if(component != null){
            var hitObject:HitObject = new HitObject();
            hitObject.set_component(component);
            hitObjectArray.push(hitObject);
        }

        var port:Port = isOnPort(coordinate);
        if(port != null){
            var hitObject:HitObject = new HitObject();
            hitObject.set_port(port);
            hitObjectArray.push(hitObject);
        }

        return hitObjectArray;
    }

    /**
    * verify this coordinate in component or not
    * @param coordinate
    * @return if the coordinate in a component then return the component
    *           or  return null;
    **/
    function isInComponent(coordinate:Coordinate):Component{
        if(isInScope(component.get_xPosition(), component.get_yPosition(), coordinate.get_xPosition(), coordinate.get_yPosition(), component.get_height(), component.get_width()) == true){
            return component;
        }
        return null;
    }

    /**
    * verify a mouse position is in a scope or not
     * @param orignalXposition   xposition of the component
     * @param orignalYposition   yposition of the component
     * @param mouseXPosition
     * @param mouseYposition
     * @param heigh
     * @param width
     * @reutrn if in the scope, return true; otherwise, return false;
    **/
    function isInScope(orignalXposition:Float, orignalYposition:Float, mouseXPosition:Float, mouseYposition:Float, heigh:Float, width:Float):Bool{
        if((mouseXPosition >= Math.abs(orignalXposition - width/2) && mouseXPosition <= orignalXposition + width/2)&&(mouseYposition >= Math.abs(orignalYposition - heigh/2) && mouseYposition <= orignalYposition + heigh/2)){
            return true;
        }else{
            return false;
        }
    }

    /**
    * verify this coordinate on port or not
    * @param coordinate
    * @return if the coordinate on the port then return the port
    *           or  return null;
    **/
    function isOnPort(cooridnate:Coordinate):Port{
        var port:Port;

            for(j in component.get_inportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    port = j;
                    return port;
                }
            }
            for(j in component.get_outportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    port = j;
                    return port;
                }
            }

        return null;
    }


    /**
    * verify a point is in a circuit or not
     * @param coordinate     the point need to be verified
     * @param orignalXPosition   the circuit x position
     * @param orignalYPosition   the circuit y position
     * @return if in the circle, return true; otherwise, return false;
    **/
    function isInCircle(coordinate:Coordinate, orignalXPosition:Float, orignalYPosition:Float):Bool{
        //the radius is 3
        if(Math.abs(coordinate.get_xPosition() - orignalXPosition) <= portRadius && Math.abs(coordinate.get_yPosition() - orignalYPosition) <= portRadius){
            return true;
        }else{
            return false;
        }
    }

    /**
    * for all component kinds except compound component, find world point always return a empty list
    **/
    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        return new Array<WorldPoint>();
    }

    public function getInnerCircuitDiagram():CircuitDiagramI{
        return null;//for most of the componentkind it has no circuit diagram inside, except compound component
    }

    public function createXML():Xml{
        var componentKindXML:Xml = Xml.createElement("Component Kind");//root

        var sequenceXML:Xml = Xml.createElement("sequence");
        componentKindXML.addChild(sequenceXML);
        sequenceXML.addChild(Xml.createPCData(sequence + ""));
        return componentKindXML;
    }
}
