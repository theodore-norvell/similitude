package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Link;
import com.mun.type.Type.Object;
/**
* move component
* @author wanhui
**/
class MoveCommand implements Command {
    var component:Component;
    var link:Link;
    var endpoint:Endpoint;
    var newXPosition:Float;
    var newYPosition:Float;
    var oldXPosition:Float;
    var oldYPosition:Float;
    var circuitDiagram:CircuitDiagramI;
    var recordXpositionBeforeUndo:Float;//also it represents the leftendpoint of a link
    var recordYpositionBefoerUndo:Float;//also it represents the leftendpoint of a link
    var recordRightEndpointXpositionBeforeUndo:Float;//also it represents the rightendpoint of a link
    var recordRightEndpointYpositionBeforeUndo:Float;//also it represents the rightendpoint of a link
    var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};


    public function new(object:Object, newXPosition:Float, newYPosition:Float, oldXPosition:Float, oldYPosition:Float, circuitDiagram:CircuitDiagramI) {
        this.component = object.component;
        this.link = object.link;
        this.endpoint = object.endPoint;
        this.newXPosition = newXPosition;
        this.newYPosition = newYPosition;
        this.oldXPosition = oldXPosition;
        this.oldYPosition = oldYPosition;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        if (component != null) {
            recordXpositionBeforeUndo = component.get_xPosition();
            recordYpositionBefoerUndo = component.get_yPosition();

            component.set_xPosition(oldXPosition);
            component.set_yPosition(oldYPosition);
            component.updateMoveComponentPortPosition(oldXPosition, oldYPosition);
            linkPositionUpdate();
            object.component = component;
        }

        if (link != null) {
            recordXpositionBeforeUndo =link.get_leftEndpoint().get_xPosition();
            recordYpositionBefoerUndo =link.get_leftEndpoint().get_yPosition();
            recordRightEndpointXpositionBeforeUndo = link.get_rightEndpoint().get_xPosition();
            recordRightEndpointYpositionBeforeUndo = link.get_rightEndpoint().get_yPosition();

            var xDifference:Float = newXPosition - oldXPosition;
            var yDifference:Float = newYPosition - oldYPosition;

            link.get_leftEndpoint().set_xPosition(link.get_leftEndpoint().get_xPosition());
            link.get_leftEndpoint().set_yPosition(link.get_leftEndpoint().get_yPosition());
            link.get_rightEndpoint().set_xPosition(link.get_rightEndpoint().get_xPosition() - xDifference);
            link.get_rightEndpoint().set_yPosition(link.get_rightEndpoint().get_yPosition() - yDifference);
            object.link = link;
        }

        if (endpoint != null) {
            recordXpositionBeforeUndo = endpoint.get_xPosition();
            recordYpositionBefoerUndo = endpoint.get_yPosition();

            getLink();
            endpoint.set_xPosition(oldXPosition);
            endpoint.set_yPosition(oldYPosition);
        }
        return object;
    }

    public function redo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        if (component != null) {
            object.component = component;
            component.set_xPosition(recordXpositionBeforeUndo);
            component.set_yPosition(recordYpositionBefoerUndo);
            component.updateMoveComponentPortPosition(recordXpositionBeforeUndo, recordYpositionBefoerUndo);
            linkPositionUpdate();
        }

        if (link != null) {
            object.link = link;

            link.get_leftEndpoint().set_xPosition(recordXpositionBeforeUndo);
            link.get_leftEndpoint().set_yPosition(recordYpositionBefoerUndo);

            link.get_rightEndpoint().set_xPosition(recordRightEndpointXpositionBeforeUndo);
            link.get_rightEndpoint().set_yPosition(recordRightEndpointYpositionBeforeUndo);
        }

        if (endpoint != null) {
            getLink();
            endpoint.set_xPosition(recordXpositionBeforeUndo);
            endpoint.set_yPosition(recordYpositionBefoerUndo);
        }
        return object;
    }

    public function execute():Void {
        if (component != null) {
            component.set_xPosition(newXPosition);
            component.set_yPosition(newYPosition);
            component.updateMoveComponentPortPosition(newXPosition, newYPosition);
            linkPositionUpdate();
        }

        if (link != null) {
            link.get_leftEndpoint().set_xPosition(newXPosition);
            link.get_leftEndpoint().set_yPosition(newYPosition);

            var xDisplacement:Float = newXPosition - oldXPosition;
            var yDisplacement:Float = newYPosition - oldYPosition;

            link.get_rightEndpoint().set_xPosition(link.get_rightEndpoint().get_xPosition() + xDisplacement);
            link.get_rightEndpoint().set_yPosition(link.get_rightEndpoint().get_yPosition() + yDisplacement);
        }

        if (endpoint != null) {
            endpoint.set_xPosition(newXPosition);
            endpoint.set_yPosition(newYPosition);
        }
    }

    function linkPositionUpdate(){
        for(i in circuitDiagram.get_linkIterator()){
            i.get_leftEndpoint().updatePosition();
            i.get_rightEndpoint().updatePosition();
        }
    }

    function getLink(){
        for (i in circuitDiagram.get_linkIterator()) {
            if (i.get_leftEndpoint() == endpoint) {
                object.link = link;
                break;
            }

            if (i.get_rightEndpoint() == endpoint) {
                object.link = link;
                break;
            }
        }
    }
}
