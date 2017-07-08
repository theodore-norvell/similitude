package com.mun.controller.command;

import com.mun.type.LinkAndComponentArray;
import com.mun.model.component.Component;
import com.mun.model.enumeration.Orientation;
/**
* change the Orientation
* @author wanhui
**/
class OrientationCommand implements Command {
    var componentArray:Array<Component> = new Array<Component>();
    var newOrientation:Orientation;
    var oldOrientationArray:Array<Orientation> = new Array<Orientation>();
    var linkAndComponentArray:LinkAndComponentArray;

    public function new(componentArray:Array<Component>, newOrientation:Orientation) {
        linkAndComponentArray = new LinkAndComponentArray();

        for(i in componentArray){
            this.componentArray.push(i);
        }

        this.newOrientation = newOrientation;

        linkAndComponentArray.set_componentArray(this.componentArray);

        for(i in 0...componentArray.length){
            oldOrientationArray[i] = componentArray[i].get_orientation();
        }
    }

    public function undo():LinkAndComponentArray {
        for(i in 0...componentArray.length){
            componentArray[i].set_orientation(oldOrientationArray[i]);
            componentArray[i].updateMoveComponentPortPosition(componentArray[i].get_xPosition(), componentArray[i].get_yPosition());
        }
        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentArray {
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
