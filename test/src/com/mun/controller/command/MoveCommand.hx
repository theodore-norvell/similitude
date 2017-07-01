package com.mun.controller.command;

import com.mun.model.component.Component;
import com.mun.model.component.Endpoint;
import com.mun.controller.componentUpdate.CircuitDiagramUtil;
import com.mun.model.component.Link;
import com.mun.model.component.Port;
import com.mun.model.component.CircuitDiagramI;
import com.mun.type.Type.LinkAndComponentAndEndpointArray;
import com.mun.type.Type.LinkAndComponentArray;
import com.mun.type.Type.Coordinate;
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
    var circuitDiagramUtil:CircuitDiagramUtil;

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

    var linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointArray = {"linkArray":new Array<Link>(), "componentArray":new Array<Component>(), "endpointArray":new Array<Endpoint>()};
    var linkAndComponentArray:LinkAndComponentArray = {"linkArray":null, "componentArray":null};

    //the displacement use new mouse location position minus mouse down location
    public function new(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointArray, xDisplacement:Float, yDisplacement:Float, circuitDiagram:CircuitDiagramI) {

        for(i in linkAndComponentAndEndpointArray.componentArray){
            this.linkAndComponentAndEndpointArray.componentArray.push(i);
        }

        for(i in linkAndComponentAndEndpointArray.linkArray){
            this.linkAndComponentAndEndpointArray.linkArray.push(i);
        }

        for(i in linkAndComponentAndEndpointArray.endpointArray){
            this.linkAndComponentAndEndpointArray.endpointArray.push(i);
        }

        linkAndComponentArray.componentArray = this.linkAndComponentAndEndpointArray.componentArray;
        linkAndComponentArray.linkArray = this.linkAndComponentAndEndpointArray.linkArray;

        circuitDiagramUtil = new CircuitDiagramUtil(circuitDiagram);

        if(linkAndComponentAndEndpointArray.componentArray.length != 0){
            for(i in 0...linkAndComponentAndEndpointArray.componentArray.length){
                oldComponentXpositionArray[i] = linkAndComponentAndEndpointArray.componentArray[i].get_xPosition();
                oldComponentYpositionArray[i] = linkAndComponentAndEndpointArray.componentArray[i].get_yPosition();
            }
        }

        if(linkAndComponentAndEndpointArray.linkArray.length != 0){
            for(i in 0...linkAndComponentAndEndpointArray.linkArray.length){
                oldLinkLeftXpositionArray[i] =  linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().get_xPosition();
                oldLinkLeftYpositionArray[i] =  linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().get_yPosition();
                oldLinkRightXpositionArray[i] = linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().get_xPosition();
                oldLinkRightYpositionArray[i] = linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().get_yPosition();
            }
        }

        if(linkAndComponentAndEndpointArray.endpointArray.length != 0){
            for(i in 0...linkAndComponentAndEndpointArray.endpointArray.length){
                oldEndpointXPositionArray[i] =  linkAndComponentAndEndpointArray.endpointArray[i].get_xPosition();
                oldEndpointYPositionArray[i] =  linkAndComponentAndEndpointArray.endpointArray[i].get_yPosition();
            }
        }

        this.xDisplacement = xDisplacement;
        this.yDisplacement = yDisplacement;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentArray {
        if (linkAndComponentAndEndpointArray.componentArray.length != 0) {
            for(i in 0...linkAndComponentAndEndpointArray.componentArray.length){

                recordComponentXpositionBeforeUndoArray[i] = linkAndComponentAndEndpointArray.componentArray[i].get_xPosition();
                recordComponentYpositionBeforeUndoArray[i] = linkAndComponentAndEndpointArray.componentArray[i].get_yPosition();

                linkAndComponentAndEndpointArray.componentArray[i].set_xPosition(oldComponentXpositionArray[i]);
                linkAndComponentAndEndpointArray.componentArray[i].set_yPosition(oldComponentYpositionArray[i]);

                linkAndComponentAndEndpointArray.componentArray[i].updateMoveComponentPortPosition(oldComponentXpositionArray[i], oldComponentYpositionArray[i]);
            }
            componentMeetEndpoint();
            linkPositionUpdate();
        }

        if (linkAndComponentAndEndpointArray.linkArray.length != 0) {
            for(i in 0...linkAndComponentAndEndpointArray.linkArray.length){

                recordLeftEndpointXpositionBeforeUndoArray[i] =  linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().get_xPosition();
                recordLeftEndpointYpositionBeforeUndoArray[i] =  linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().get_yPosition();
                recordRightEndpointXpositionBeforeUndoArray[i] = linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().get_xPosition();
                recordRightEndpointYpositionBeforeUndoArray[i] = linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().get_yPosition();

                linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().set_xPosition(oldLinkLeftXpositionArray[i]);
                linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().set_yPosition(oldLinkLeftYpositionArray[i]);
                linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().set_xPosition(oldLinkRightXpositionArray[i]);
                linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().set_yPosition(oldLinkRightYpositionArray[i]);

                linkMeetPortUpdate(linkAndComponentAndEndpointArray.linkArray[i]);
            }
        }

        if (linkAndComponentAndEndpointArray.endpointArray.length != 0) {
            for(i in 0...linkAndComponentAndEndpointArray.endpointArray.length){
                recordEndpointXpositionBeforeUndoArray[i] = linkAndComponentAndEndpointArray.endpointArray[i].get_xPosition();
                recordEndpointYpositionBeforeUndoArray[i] = linkAndComponentAndEndpointArray.endpointArray[i].get_yPosition();

                linkAndComponentAndEndpointArray.endpointArray[i].set_xPosition(oldEndpointXPositionArray[i]);
                linkAndComponentAndEndpointArray.endpointArray[i].set_yPosition(oldEndpointYPositionArray[i]);

                endpointMeetPort(linkAndComponentAndEndpointArray.endpointArray[i]);
            }
        }
        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentArray {
        if (linkAndComponentAndEndpointArray.componentArray.length != 0) {
            for(i in 0...linkAndComponentAndEndpointArray.componentArray.length){
                linkAndComponentAndEndpointArray.componentArray[i].set_xPosition(recordComponentXpositionBeforeUndoArray[i]);
                linkAndComponentAndEndpointArray.componentArray[i].set_yPosition(recordComponentYpositionBeforeUndoArray[i]);
                linkAndComponentAndEndpointArray.componentArray[i].updateMoveComponentPortPosition(recordComponentXpositionBeforeUndoArray[i], recordComponentYpositionBeforeUndoArray[i]);
            }
            componentMeetEndpoint();
            linkPositionUpdate();
        }

        if (linkAndComponentAndEndpointArray.linkArray.length != 0) {
            for(i in 0...linkAndComponentAndEndpointArray.linkArray.length){
                linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().set_xPosition(recordLeftEndpointXpositionBeforeUndoArray[i]);
                linkAndComponentAndEndpointArray.linkArray[i].get_leftEndpoint().set_yPosition(recordLeftEndpointYpositionBeforeUndoArray[i]);
                linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().set_xPosition(recordRightEndpointXpositionBeforeUndoArray[i]);
                linkAndComponentAndEndpointArray.linkArray[i].get_rightEndpoint().set_yPosition(recordRightEndpointYpositionBeforeUndoArray[i]);

                linkMeetPortUpdate(linkAndComponentAndEndpointArray.linkArray[i]);
            }
        }

        if (linkAndComponentAndEndpointArray.endpointArray.length != 0) {
            for(i in 0...linkAndComponentAndEndpointArray.endpointArray.length){
                linkAndComponentAndEndpointArray.endpointArray[i].set_xPosition(recordEndpointXpositionBeforeUndoArray[i]);
                linkAndComponentAndEndpointArray.endpointArray[i].set_yPosition(recordEndpointYpositionBeforeUndoArray[i]);

                endpointMeetPort(linkAndComponentAndEndpointArray.endpointArray[i]);
            }
        }
        return linkAndComponentArray;
    }

    public function execute():Void {
        if (linkAndComponentAndEndpointArray.componentArray.length != 0) {
            for(i in linkAndComponentAndEndpointArray.componentArray){
                i.set_xPosition(i.get_xPosition() + xDisplacement);
                i.set_yPosition(i.get_yPosition() + yDisplacement);
                i.updateMoveComponentPortPosition(i.get_xPosition(), i.get_yPosition());
            }
            componentMeetEndpoint();
            linkPositionUpdate();
        }

        if (linkAndComponentAndEndpointArray.linkArray.length != 0) {
            for(i in linkAndComponentAndEndpointArray.linkArray){
                i.get_leftEndpoint().set_xPosition(i.get_leftEndpoint().get_xPosition() + xDisplacement);
                i.get_leftEndpoint().set_yPosition(i.get_leftEndpoint().get_yPosition() + yDisplacement);
                i.get_rightEndpoint().set_xPosition(i.get_rightEndpoint().get_xPosition() + xDisplacement);
                i.get_rightEndpoint().set_yPosition(i.get_rightEndpoint().get_yPosition() + yDisplacement);

                linkMeetPortUpdate(i);
            }
        }

        if (linkAndComponentAndEndpointArray.endpointArray.length != 0) {
            for(i in linkAndComponentAndEndpointArray.endpointArray){
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
        var leftEndpointCoordinate:Coordinate = {"xPosition":link.get_leftEndpoint().get_xPosition(), "yPosition":link.get_leftEndpoint().get_yPosition()};
        var port_temp:Port = circuitDiagramUtil.isOnPort(leftEndpointCoordinate).port;
        var leftEndpointPort:Port = link.get_leftEndpoint().get_port();
        if(port_temp != null && leftEndpointPort != port_temp){//left endpoint met a port
            link.get_leftEndpoint().set_port(port_temp);
        }else if(port_temp == null){
            link.get_leftEndpoint().set_port(null);
        }

        var rightEndpointCoordinate:Coordinate = {"xPosition":link.get_rightEndpoint().get_xPosition(), "yPosition":link.get_rightEndpoint().get_yPosition()};
        port_temp = circuitDiagramUtil.isOnPort(rightEndpointCoordinate).port;
        var rightEndpointPort:Port = link.get_rightEndpoint().get_port();

        if(port_temp != null && rightEndpointPort != port_temp){//left endpoint met a port
            link.get_rightEndpoint().set_port(port_temp);
        }else if(port_temp == null){
            link.get_rightEndpoint().set_port(null);
        }
    }

    function endpointMeetPort(endpoint:Endpoint){
        var coordinate:Coordinate = {"xPosition":endpoint.get_xPosition(), "yPosition":endpoint.get_yPosition()};
        var newPort:Port = circuitDiagramUtil.isOnPort(coordinate).port;
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

    public function linkPositionUpdate(){
        for(i in circuitDiagram.get_linkIterator()){
            i.get_leftEndpoint().updatePosition();
            i.get_rightEndpoint().updatePosition();
        }
    }
}
