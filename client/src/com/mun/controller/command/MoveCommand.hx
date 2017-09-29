package com.mun.controller.command;

import com.mun.type.Object;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.type.Coordinate;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Link;
import com.mun.model.component.Port;
import com.mun.model.component.CircuitDiagramI;
import com.mun.global.Constant.*;
/**
* move component
*
* Move action infulence the performance significantlly because every move will create a new move command which take lots of resources.
* Moreover, continuously moving need to redraw the canvas very frequently
*
* @author wanhui
**/
class MoveCommand implements Command {
    var xDisplacement:Float;
    var yDisplacement:Float;
    var circuitDiagram:CircuitDiagramI;

    var recordComponentXpositionBeforeUndoArray:Array<Float> = new Array<Float>();//for component
    var recordComponentYpositionBeforeUndoArray:Array<Float> = new Array<Float>();//for component

    var recordLeftEndpointXpositionBeforeUndoArray:Array<Float> = new Array<Float>(); //for link
    var recordLeftEndpointYpositionBeforeUndoArray:Array<Float> = new Array<Float>(); //for link
    var recordRightEndpointXpositionBeforeUndoArray:Array<Float> = new Array<Float>();//for link
    var recordRightEndpointYpositionBeforeUndoArray:Array<Float> = new Array<Float>();//for link

    var recordEndpointXpositionBeforeUndoArray:Array<Float> = new Array<Float>();
    var recordEndpointYpositionBeforeUndoArray:Array<Float> = new Array<Float>();

    var oldComponentXpositionArray:Array<Float> = new Array<Float>();
    var oldComponentYpositionArray:Array<Float> = new Array<Float>();

    var oldLinkLeftXpositionArray:Array<Float> = new Array<Float>();
    var oldLinkLeftYpositionArray:Array<Float> = new Array<Float>();
    var oldLinkRightXpositionArray:Array<Float> = new Array<Float>();
    var oldLinkRightYpositionArray:Array<Float> = new Array<Float>();

    var oldEndpointXPositionArray:Array<Float> = new Array<Float>();
    var oldEndpointYPositionArray:Array<Float> = new Array<Float>();

    var linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
    var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();

    //the displacement use new mouse location position minus mouse down location
    public function new(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointAndPortArray, xDisplacement:Float, yDisplacement:Float, circuitDiagram:CircuitDiagramI) {

        for(i in linkAndComponentAndEndpointArray.get_componentIterator()){
            this.linkAndComponentAndEndpointArray.addComponent(i);
            this.linkAndComponentArray.addComponent(i);
        }

        for(i in linkAndComponentAndEndpointArray.get_linkIterator()){
            this.linkAndComponentAndEndpointArray.addLink(i);
            linkAndComponentArray.addLink(i);
        }

        for(i in linkAndComponentAndEndpointArray.get_endpointIterator()){
            this.linkAndComponentAndEndpointArray.addEndpoint(i);
        }

        var i:Int = 0;
        if(linkAndComponentAndEndpointArray.getComponentIteratorLength() != 0){
            for(j in linkAndComponentAndEndpointArray.get_componentIterator()){
                oldComponentXpositionArray[i] = j.get_xPosition();
                oldComponentYpositionArray[i] = j.get_yPosition();
                i++;
            }
        }
        i = 0;//reset i
        if(linkAndComponentAndEndpointArray.getLinkIteratorLength() != 0){
            for(j in linkAndComponentAndEndpointArray.get_linkIterator()){
                oldLinkLeftXpositionArray[i] =  j.get_leftEndpoint().get_xPosition();
                oldLinkLeftYpositionArray[i] =  j.get_leftEndpoint().get_yPosition();
                oldLinkRightXpositionArray[i] = j.get_rightEndpoint().get_xPosition();
                oldLinkRightYpositionArray[i] = j.get_rightEndpoint().get_yPosition();
                i++;
            }
        }

        i = 0;//reset i
        if(linkAndComponentAndEndpointArray.getEndppointIteratorLength() != 0){
            for(j in linkAndComponentAndEndpointArray.get_endpointIterator()){
                oldEndpointXPositionArray[i] =  j.get_xPosition();
                oldEndpointYPositionArray[i] =  j.get_yPosition();
                i++;
            }
        }

        this.xDisplacement = xDisplacement;
        this.yDisplacement = yDisplacement;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray {
        var i:Int = 0;
        if (linkAndComponentAndEndpointArray.getComponentIteratorLength() != 0) {
            for(j in linkAndComponentAndEndpointArray.get_componentIterator()){

                recordComponentXpositionBeforeUndoArray[i] = j.get_xPosition();
                recordComponentYpositionBeforeUndoArray[i] = j.get_yPosition();

                j.set_xPosition(oldComponentXpositionArray[i]);
                j.set_yPosition(oldComponentYpositionArray[i]);

                j.updateMoveComponentPortPosition(oldComponentXpositionArray[i], oldComponentYpositionArray[i]);

                i++;
            }
            linkPositionUpdate();
        }

        i = 0;//reset i
        if (linkAndComponentAndEndpointArray.getLinkIteratorLength() != 0) {
            for(j in linkAndComponentAndEndpointArray.get_linkIterator()){

                recordLeftEndpointXpositionBeforeUndoArray[i] =  j.get_leftEndpoint().get_xPosition();
                recordLeftEndpointYpositionBeforeUndoArray[i] =  j.get_leftEndpoint().get_yPosition();
                recordRightEndpointXpositionBeforeUndoArray[i] = j.get_rightEndpoint().get_xPosition();
                recordRightEndpointYpositionBeforeUndoArray[i] = j.get_rightEndpoint().get_yPosition();

                j.get_leftEndpoint().set_xPosition(oldLinkLeftXpositionArray[i]);
                j.get_leftEndpoint().set_yPosition(oldLinkLeftYpositionArray[i]);
                j.get_rightEndpoint().set_xPosition(oldLinkRightXpositionArray[i]);
                j.get_rightEndpoint().set_yPosition(oldLinkRightYpositionArray[i]);

                linkMeetPortUpdate(j);
                i++;
            }
        }

        i = 0;//reset i
        if (linkAndComponentAndEndpointArray.getEndppointIteratorLength() != 0) {
            for(j in linkAndComponentAndEndpointArray.get_endpointIterator()){
                recordEndpointXpositionBeforeUndoArray[i] = j.get_xPosition();
                recordEndpointYpositionBeforeUndoArray[i] = j.get_yPosition();

                j.set_xPosition(oldEndpointXPositionArray[i]);
                j.set_yPosition(oldEndpointYPositionArray[i]);

                endpointMeetPort(j);
                i++;
            }
        }
        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentAndEndpointAndPortArray {
        var i:Int = 0;
        if (linkAndComponentAndEndpointArray.getComponentIteratorLength() != 0) {
            for(j in linkAndComponentAndEndpointArray.get_componentIterator()){
                j.set_xPosition(recordComponentXpositionBeforeUndoArray[i]);
                j.set_yPosition(recordComponentYpositionBeforeUndoArray[i]);
                j.updateMoveComponentPortPosition(recordComponentXpositionBeforeUndoArray[i], recordComponentYpositionBeforeUndoArray[i]);
                i++;
            }
            linkPositionUpdate();
        }

        i = 0;//reset i
        if (linkAndComponentAndEndpointArray.getLinkIteratorLength() != 0) {
            for(j in linkAndComponentAndEndpointArray.get_linkIterator()){
                j.get_leftEndpoint().set_xPosition(recordLeftEndpointXpositionBeforeUndoArray[i]);
                j.get_leftEndpoint().set_yPosition(recordLeftEndpointYpositionBeforeUndoArray[i]);
                j.get_rightEndpoint().set_xPosition(recordRightEndpointXpositionBeforeUndoArray[i]);
                j.get_rightEndpoint().set_yPosition(recordRightEndpointYpositionBeforeUndoArray[i]);

                linkPositionUpdate();
                i++;
            }
        }

        i = 0;//reset i
        if (linkAndComponentAndEndpointArray.getEndppointIteratorLength() != 0) {
            for(j in linkAndComponentAndEndpointArray.get_endpointIterator()){
                j.set_xPosition(recordEndpointXpositionBeforeUndoArray[i]);
                j.set_yPosition(recordEndpointYpositionBeforeUndoArray[i]);

                endpointMeetPort(j);
                i++;
            }
        }
        return linkAndComponentArray;
    }

    public function execute():Void {
        if (linkAndComponentAndEndpointArray.getComponentIteratorLength() != 0) {
            for(i in linkAndComponentAndEndpointArray.get_componentIterator()){
                i.set_xPosition(i.get_xPosition() + xDisplacement);
                i.set_yPosition(i.get_yPosition() + yDisplacement);
                i.updateMoveComponentPortPosition(i.get_xPosition(), i.get_yPosition());
            }
            componentMeetEndpoint();
            linkPositionUpdate();
        }

        if (linkAndComponentAndEndpointArray.getLinkIteratorLength() != 0) {
            for(i in linkAndComponentAndEndpointArray.get_linkIterator()){
                if(i.get_leftEndpoint().get_port() == null){
                    i.get_leftEndpoint().set_xPosition(i.get_leftEndpoint().get_xPosition() + xDisplacement);
                    i.get_leftEndpoint().set_yPosition(i.get_leftEndpoint().get_yPosition() + yDisplacement);
                }
                if(i.get_rightEndpoint().get_port() == null){
                    i.get_rightEndpoint().set_xPosition(i.get_rightEndpoint().get_xPosition() + xDisplacement);
                    i.get_rightEndpoint().set_yPosition(i.get_rightEndpoint().get_yPosition() + yDisplacement);
                }
                linkMeetPortUpdate(i);
            }
        }

        if (linkAndComponentAndEndpointArray.getEndppointIteratorLength() != 0) {
            for(i in linkAndComponentAndEndpointArray.get_endpointIterator()){
                i.set_xPosition(i.get_xPosition() + xDisplacement);
                i.set_yPosition(i.get_yPosition() + yDisplacement);

                endpointMeetPort(i);
            }
        }
    }

    function componentMeetEndpoint(){
        for(i in circuitDiagram.get_linkIterator()){
            linkMeetPortUpdate(i);
        }
    }

    function linkMeetPortUpdate(link:Link){
        //verfy the endpoint of this link connect to a port or not while moving
        //left endpoint
        var leftEndpointPort:Port = link.get_leftEndpoint().get_port();
        if(leftEndpointPort == null){
            var leftEndpointCoordinate:Coordinate = new Coordinate(link.get_leftEndpoint().get_xPosition(), link.get_leftEndpoint().get_yPosition());
            var port_temp:Port = isOnPort(leftEndpointCoordinate).get_port();
            if(port_temp != null && leftEndpointPort != port_temp){//left endpoint met a port
                link.get_leftEndpoint().set_port(port_temp);
            }else if(port_temp == null){
                link.get_leftEndpoint().set_port(null);
            }
        }

        var rightEndpointPort:Port = link.get_rightEndpoint().get_port();
        if(rightEndpointPort == null){
            var rightEndpointCoordinate:Coordinate = new Coordinate(link.get_rightEndpoint().get_xPosition(), link.get_rightEndpoint().get_yPosition());
            var port_temp:Port = isOnPort(rightEndpointCoordinate).get_port();
            if(port_temp != null && rightEndpointPort != port_temp){//left endpoint met a port
                link.get_rightEndpoint().set_port(port_temp);
            }else if(port_temp == null){
                link.get_rightEndpoint().set_port(null);
            }
        }

    }

    function endpointMeetPort(endpoint:Endpoint){
        var coordinate:Coordinate = new Coordinate(endpoint.get_xPosition(), endpoint.get_yPosition());
        var newPort:Port = isOnPort(coordinate).get_port();
        if(newPort != null){
            for(i in circuitDiagram.get_linkIterator()){
                var port:Port = null;
                if(i.get_leftEndpoint() == endpoint){
                    port = i.get_rightEndpoint().get_port();

                    //verify the endpoint step into another port or not
                    if(newPort != port){
                        i.get_leftEndpoint().set_port(newPort);
                    }else{
                        i.get_leftEndpoint().set_port(null);
                    }
                    break;
                }

                if(i.get_rightEndpoint() == endpoint){
                    port = i.get_leftEndpoint().get_port();
                    if(newPort != port){
                        i.get_rightEndpoint().set_port(newPort);
                    }else{
                        i.get_rightEndpoint().set_port(null);
                    }
                    break;
                }
            }
        }else{
            endpoint.set_port(null);
        }

    }

    function linkPositionUpdate(){
        for(i in circuitDiagram.get_linkIterator()){
            i.get_leftEndpoint().updatePosition();
            i.get_rightEndpoint().updatePosition();
        }
    }

    /**
    * verify this coordinate on port or not
    * @param coordinate
    * @return if the coordinate on the port then return the port
    *           or  return null;
    **/
    public function isOnPort(cooridnate:Coordinate):Object{
        var object:Object = new Object();
        for(i in circuitDiagram.get_componentIterator()){
            for(j in i.get_inportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.set_port(j);
                    for(k in circuitDiagram.get_linkIterator()){
                        object.set_endPoint(isLinkOnPort(k,j));
                        return object;
                    }
                }
            }
            for(j in i.get_outportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.set_port(j);
                    for(k in circuitDiagram.get_linkIterator()){
                        object.set_endPoint(isLinkOnPort(k,j));
                        return object;
                    }
                }
            }
        }
        return object;
    }

    /**
    * verify the link on the port or not
     * @param link
     * @param port
     * @return endpoint   if one of the endpoint on the port, then return this endpoint
     *                          or return null
    **/
    function isLinkOnPort(link:Link, port:Port):Endpoint{
        var endpoint:Endpoint = null;
        //if this port has a endpoint (left)
        if(isEndpointOnPort(link.get_leftEndpoint(), port)){
            endpoint = link.get_leftEndpoint();
        }
        //if this port has a endpoint (right)
        if(isEndpointOnPort(link.get_rightEndpoint(), port)){
            endpoint = link.get_rightEndpoint();
        }
        return endpoint;
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
    * verify the endpoint on the port or not
     * @param endpoint
     * @param port
     * @return Bool   if the endpoint on the port, return true; otherwise, return false;
    **/
    function isEndpointOnPort(endpoint:Endpoint, port:Port):Bool{
        if(endpoint.get_xPosition() == port.get_xPosition() && endpoint.get_yPosition() == port.get_yPosition()){
            return true;
        }else{
            return false;
        }
    }
}
