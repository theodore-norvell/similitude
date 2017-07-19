package com.mun.controller.command;

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

    public function new(componentArray:Array<Component>, newOrientation:ORIENTATION) {
        linkAndComponentArray = new LinkAndComponentAndEndpointAndPortArray();

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
    }
}
