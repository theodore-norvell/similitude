package com.mun.controller.command;

import com.mun.model.component.CircuitDiagram;
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
    var circuitDiagram:CircuitDiagram;


    public function new(object:Object, newXPosition:Float, newYPosition:Float, oldXPosition:Float, oldYPosition:Float, circuitDiagram:CircuitDiagram) {
        this.component = object.component;
        this.link = object.link;
        this.endpoint = object.endPoint;
        this.newXPosition = newXPosition;
        this.newYPosition = newYPosition;
        this.oldXPosition = oldXPosition;
        this.oldYPosition = oldYPosition;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():Void {
        if (component != null) {

            var index = circuitDiagram.get_componentArray().indexOf(component);
            circuitDiagram.get_componentArray()[index].set_xPosition(oldXPosition);
            circuitDiagram.get_componentArray()[index].set_yPosition(oldYPosition);
            circuitDiagram.get_componentArray()[index].updateMoveComponentPortPosition(oldXPosition, oldYPosition);
        }

        if (link != null) {
            var xDifference:Float = newXPosition - oldXPosition;
            var yDifference:Float = newYPosition - oldYPosition;

            var index = circuitDiagram.get_linkArray().indexOf(link);
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().set_xPosition(link.get_leftEndpoint().get_xPosition() - xDifference);
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().set_yPosition(link.get_leftEndpoint().get_yPosition() - yDifference);
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().set_xPosition(link.get_rightEndpoint().get_xPosition() - xDifference);
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().set_yPosition(link.get_rightEndpoint().get_yPosition() - yDifference);
        }

        if (endpoint != null) {
            for (i in 0...circuitDiagram.get_linkArray().length) {
                if (circuitDiagram.get_linkArray()[i].get_leftEndpoint() == endpoint) {
                    circuitDiagram.get_linkArray()[i].get_leftEndpoint().set_xPosition(oldXPosition);
                    circuitDiagram.get_linkArray()[i].get_leftEndpoint().set_yPosition(oldYPosition);
                    break;
                }

                if (circuitDiagram.get_linkArray()[i].get_rightEndpoint() == endpoint) {
                    circuitDiagram.get_linkArray()[i].get_rightEndpoint().set_xPosition(oldXPosition);
                    circuitDiagram.get_linkArray()[i].get_rightEndpoint().set_yPosition(oldYPosition);
                    break;
                }
            }
        }
    }

    public function redo():Void {
        execute();
    }

    public function execute():Void {
        if (component != null) {

            var index = circuitDiagram.get_componentArray().indexOf(component);
            circuitDiagram.get_componentArray()[index].set_xPosition(newXPosition);
            circuitDiagram.get_componentArray()[index].set_yPosition(newYPosition);
            circuitDiagram.get_componentArray()[index].updateMoveComponentPortPosition(newXPosition, newYPosition);
        }

        if (link != null) {
            var xDifference:Float = newXPosition - oldXPosition;
            var yDifference:Float = newYPosition - oldYPosition;

            var index = circuitDiagram.get_linkArray().indexOf(link);
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().set_xPosition(link.get_leftEndpoint().get_xPosition() + xDifference);
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().set_yPosition(link.get_leftEndpoint().get_yPosition() + yDifference);
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().set_xPosition(link.get_rightEndpoint().get_xPosition() + xDifference);
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().set_yPosition(link.get_rightEndpoint().get_yPosition() + yDifference);
        }

        if (endpoint != null) {
            for (i in 0...circuitDiagram.get_linkArray().length) {
                if (circuitDiagram.get_linkArray()[i].get_leftEndpoint() == endpoint) {
                    circuitDiagram.get_linkArray()[i].get_leftEndpoint().set_xPosition(newXPosition);
                    circuitDiagram.get_linkArray()[i].get_leftEndpoint().set_yPosition(newYPosition);
                    break;
                }

                if (circuitDiagram.get_linkArray()[i].get_rightEndpoint() == endpoint) {
                    circuitDiagram.get_linkArray()[i].get_rightEndpoint().set_xPosition(newXPosition);
                    circuitDiagram.get_linkArray()[i].get_rightEndpoint().set_yPosition(newYPosition);
                    break;
                }
            }
        }
    }
}
