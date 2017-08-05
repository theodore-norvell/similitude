package com.mun.controller.command;

import com.mun.model.component.Endpoint;
import com.mun.type.Coordinate;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
/**
* paste command
* @author wanhui
**/
class PasteCommand implements Command {
    var copyStack:Stack;
    var xPosition:Float;
    var yPosition:Float;
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray;


    public function new(xPosition:Float, yPosition:Float, circuitDiagram:CircuitDiagramI) {
        linkAndComponentArray = new LinkAndComponentAndEndpointAndPortArray();
        this.copyStack = new Stack();

        for(i in circuitDiagram.getCopyStack().getLinkArray()){
            copyStack.pushLink(i);
        }

        for(i in circuitDiagram.getCopyStack().getComponentArray()){
            copyStack.pushComponent(i);
        }

        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray {

        for(i in linkAndComponentArray.get_linkIterator()){
            circuitDiagram.removeLink(i);
        }

        for(i in linkAndComponentArray.get_componentIterator()){
            circuitDiagram.removeComponent(i);
        }

        for(i in copyStack.getLinkArray()){
            circuitDiagram.getCopyStack().pushLink(i);
        }

        for(i in copyStack.getComponentArray()){
            circuitDiagram.getCopyStack().pushComponent(i);
        }

        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentAndEndpointAndPortArray {
        for(i in linkAndComponentArray.get_linkIterator()){
            circuitDiagram.addLink(i);
        }

        for(i in linkAndComponentArray.get_componentIterator()){
            circuitDiagram.addComponent(i);
        }

        circuitDiagram.getCopyStack().clearStack();

        return linkAndComponentArray;
    }

    public function execute():Void {
        var linkArray:Array<Link> = copyStack.getLinkArray();
        var componentArray:Array<Component> = copyStack.getComponentArray();
        var centerCoordinate:Coordinate = findTheCenterForCopyArrays(linkArray, componentArray);

        linkAndComponentArray.clean();
        for(i in linkArray){
            var offsetCoordinate:Coordinate = calculateEndpointOffsetCoordinate(i.get_rightEndpoint(), centerCoordinate.get_xPosition(), centerCoordinate.get_yPosition());
            i.get_rightEndpoint().set_xPosition(xPosition - offsetCoordinate.get_xPosition());
            i.get_rightEndpoint().set_yPosition(yPosition - offsetCoordinate.get_yPosition());

            offsetCoordinate = calculateEndpointOffsetCoordinate(i.get_leftEndpoint(), centerCoordinate.get_xPosition(), centerCoordinate.get_yPosition());
            i.get_leftEndpoint().set_xPosition(xPosition - offsetCoordinate.get_xPosition());
            i.get_leftEndpoint().set_yPosition(yPosition - offsetCoordinate.get_yPosition());

            linkAndComponentArray.addLink(i);

            circuitDiagram.addLink(i);
        }

        for(i in componentArray){
            var offsetCoordinate:Coordinate = calculateComponentOffsetCoordinate(i, centerCoordinate.get_xPosition(), centerCoordinate.get_yPosition());

            i.set_xPosition(xPosition + offsetCoordinate.get_xPosition());
            i.set_yPosition(yPosition + offsetCoordinate.get_yPosition());

            linkAndComponentArray.addComponent(i);

            circuitDiagram.addComponent(i);
        }
    }

    function calculateComponentOffsetCoordinate(component:Component, xPosition:Float, yPosition:Float):Coordinate{
        return new Coordinate(component.get_xPosition() - xPosition, component.get_yPosition() - yPosition);
    }

    function findTheCenterForCopyArrays(linkArray:Array<Link>, componentArray:Array<Component>):Coordinate{
        var max_x:Float = 0;
        var max_y:Float = 0;
        var min_x:Float = 99999;
        var min_y:Float = 99999;
        for(i in linkArray){
            if(i.get_rightEndpoint().get_xPosition() > max_x){
                max_x = i.get_rightEndpoint().get_xPosition();
            }
            if(i.get_rightEndpoint().get_xPosition() < min_x){
                min_x = i.get_rightEndpoint().get_xPosition();
            }

            if(i.get_rightEndpoint().get_yPosition() > max_y){
                max_y = i.get_rightEndpoint().get_yPosition();
            }
            if(i.get_rightEndpoint().get_yPosition() < min_y){
                min_y = i.get_rightEndpoint().get_yPosition();
            }

            if(i.get_leftEndpoint().get_xPosition() > max_x){
                max_x = i.get_leftEndpoint().get_xPosition();
            }
            if(i.get_leftEndpoint().get_xPosition() < min_x){
                min_x = i.get_leftEndpoint().get_xPosition();
            }

            if(i.get_leftEndpoint().get_yPosition() > max_y){
                max_y = i.get_leftEndpoint().get_yPosition();
            }
            if(i.get_leftEndpoint().get_yPosition() < min_y){
                min_y = i.get_leftEndpoint().get_yPosition();
            }
        }

        for(i in componentArray){
            var maxPosition_x:Float = i.get_xPosition() + i.get_width()/2;
            var minPosition_x:Float = i.get_xPosition() - i.get_width()/2;

            var maxPosition_y:Float = i.get_yPosition() + i.get_height()/2;
            var minPosition_y:Float = i.get_yPosition() - i.get_height()/2;

            if(maxPosition_x > max_x){
                max_x = maxPosition_x;
            }
            if(minPosition_x < min_x){
                min_x = minPosition_x;
            }

            if(maxPosition_y > max_y){
                max_y = maxPosition_y;
            }
            if(minPosition_y < min_y){
                min_y = minPosition_y;
            }
        }

        //four corners' coordinate (min_x, min_y) (min_x, max_y) (max_x, min_y) (max_x, max_y)
        //so the center coordiante for these objects could be calculated.
        return new Coordinate( (max_x - min_x)/2+min_x , (max_y - min_y)/2+min_y);
    }

    function calculateEndpointOffsetCoordinate(endpoint:Endpoint, xPosition:Float, yPosition:Float):Coordinate {

        var xOffset:Float = xPosition - endpoint.get_xPosition();
        var yOffset:Float = yPosition - endpoint.get_yPosition();

        return new Coordinate(xOffset, yOffset);
    }
}
