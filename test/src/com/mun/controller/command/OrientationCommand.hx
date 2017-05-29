package com.mun.controller.command;

import com.mun.type.Type.Object;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.enumeration.Orientation;
/**
* change the Orientation
* @author wanhui
**/
class OrientationCommand implements Command {
    var component:Component;
    var circuitDiagram:CircuitDiagramI;
    var newOrientation:Orientation;
    var oldOrientation:Orientation;
    var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};

    public function new(component:Component, oldOrientation:Orientation, newOrientation:Orientation, circuitDiagram:CircuitDiagramI) {
        this.component = component;
        this.circuitDiagram = circuitDiagram;
        this.oldOrientation = oldOrientation;
    }

    public function undo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        object.component = component;
        circuitDiagram.setNewOirentation(component, oldOrientation);
        return object;
    }

    public function redo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        execute();
        object.component = component;
        return object;
    }

    public function execute():Void {
        circuitDiagram.setNewOirentation(component, newOrientation);
    }
}
