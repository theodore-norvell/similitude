package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.component.Component;
import com.mun.model.enumeration.ORIENTATION;
/**
* change the Orientation
* @author wanhui
**/
class OrientationCommand implements Command {
    var componentArray:Array<Component> = new Array<Component>();
    var newOrientation:ORIENTATION;
    var oldOrientationArray:Array<ORIENTATION> = new Array<ORIENTATION>();
    var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray;
    var circuitDiagram:CircuitDiagramI;

    public function new(componentArray:Array<Component>, newOrientation:ORIENTATION, circuitDiagram:CircuitDiagramI) {
        linkAndComponentArray = new LinkAndComponentAndEndpointAndPortArray();

        this.circuitDiagram = circuitDiagram;

        for(i in componentArray){
            this.componentArray.push(i);
        }

        this.newOrientation = newOrientation;

        linkAndComponentArray.clean();
        for(i in 0...componentArray.length){
            linkAndComponentArray.addComponent(componentArray[i]);

            oldOrientationArray[i] = componentArray[i].get_orientation();
        }
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray {
        for(i in 0...componentArray.length){
            componentArray[i].set_orientation(oldOrientationArray[i]);
            componentArray[i].updateMoveComponentPortPosition(componentArray[i].get_xPosition(), componentArray[i].get_yPosition());
        }
        linkPositionUpdate();
        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentAndEndpointAndPortArray {
        execute();
        return linkAndComponentArray;
    }

    public function execute():Void {
        for(i in componentArray){
            i.set_orientation(newOrientation);
            i.updateMoveComponentPortPosition(i.get_xPosition(), i.get_yPosition());
        }
        linkPositionUpdate();
    }

    function linkPositionUpdate(){
        for(i in circuitDiagram.get_linkIterator()){
            i.get_leftEndpoint().updatePosition();
            i.get_rightEndpoint().updatePosition();
        }
    }
}
