package com.mun.controller.command;

import com.mun.type.LinkAndComponentAndEndpointArray;
import com.mun.type.Object;
import com.mun.type.LinkAndComponentArray;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
/**
* add command is used to process the add operation
* @author wanhui
**/
class AddCommand implements Command {
    var link:Link;
    var component:Component;
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentArray;

    public function new(object:Object, circuitDiagram:CircuitDiagramI) {
        this.link = object.get_link();
        this.component = object.get_component();
        this.circuitDiagram = circuitDiagram;

        linkAndComponentArray = new LinkAndComponentArray();
    }

    public function undo():LinkAndComponentArray {
        if (link != null) {
            circuitDiagram.removeLink(link);
            linkAndComponentArray.removeLink(link);
        }

        if (component != null) {
            circuitDiagram.removeComponent(component);
            linkAndComponentArray.removeComponent(component);
        }

        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentArray {
        execute();
        return linkAndComponentArray;
    }

    public function execute():Void {
        if (link != null) {
            circuitDiagram.addLink(link);
            linkAndComponentArray.addLink(link);
        }

        if (component != null) {
            circuitDiagram.addComponent(component);
            linkAndComponentArray.addComponent(component);
        }
    }
}
