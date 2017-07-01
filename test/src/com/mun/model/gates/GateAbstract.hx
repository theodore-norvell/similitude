package com.mun.model.gates;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.component.Component;
import com.mun.model.enumeration.MODE;
import com.mun.type.Type.Coordinate;
import com.mun.type.Type.WorldPoint;
import com.mun.type.Type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.component.Inport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.Orientation;
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

    public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        switch (orientation){
            case Orientation.EAST : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2);
                    portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
//                    if (portArray[i].get_sequence() == -1) {
//                        portArray[i].set_sequence(i);
//                    }
                }
            };
            case Orientation.NORTH : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                    portArray[i].set_yPosition(yPosition + height / 2);
//                    if (portArray[i].get_sequence() == -1) {
//                        portArray[i].set_sequence(i);
//                    }
                }
            };
            case Orientation.SOUTH : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                    portArray[i].set_yPosition(yPosition - height / 2);
//                    if (portArray[i].get_sequence() == -1) {
//                        portArray[i].set_sequence(i);
//                    }
                }
            };
            case Orientation.WEST : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition + width / 2);
                    portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
//                    if (portArray[i].get_sequence() == -1) {
//                        portArray[i].set_sequence(i);
//                    }
                }
            };
            default:{
                //do nothing
            }
        }
        return portArray;
    }

    public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>{
        switch(orientation){
            case Orientation.EAST : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition + width / 2);
                    portArray[i].set_yPosition(yPosition);
                }
            };
            case Orientation.NORTH : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition);
                    portArray[i].set_yPosition(yPosition - height / 2);
                }
            };
            case Orientation.SOUTH : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition);
                    portArray[i].set_yPosition(yPosition + height / 2);
                }
            };
            case Orientation.WEST : {
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

    public function findHitList(coordinate:Coordinate, mode:MODE):LinkAndComponentAndEndpointAndPortArray{
        var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray = {"linkArray": null, "componentArray": null, "endpointArray": null, "portArray": null};

        linkAndComponentAndEndpointAndPortArray.componentArray.push(isInComponent(coordinate));

        return linkAndComponentAndEndpointAndPortArray;
    }

    /**
    * verify this coordinate in component or not
    * @param coordinate
    * @return if the coordinate in a component then return the component
    *           or  return null;
    **/
    function isInComponent(coordinate:Coordinate):Component{
        if(isInScope(component.get_xPosition(), component.get_yPosition(), coordinate.xPosition, coordinate.yPosition, component.get_height(), component.get_width()) == true){
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
        if((mouseXPosition >= Math.abs(orignalXposition - width/2) && orignalXposition <= orignalXposition + width/2)&&(mouseYposition >= Math.abs(orignalYposition - heigh/2) && mouseYposition <= orignalYposition + heigh/2)){
            return true;
        }else{
            return false;
        }
    }
    /**
    * for all component kinds except, find world point always return a empty list
    **/
    public function findWorldPoint(coordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        return new Array<WorldPoint>();
    }

}
