package com.mun.controller.command;

import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.type.Object;
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
    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;

    public function new(object:Object, circuitDiagram:CircuitDiagramI) {
        this.link = object.get_link();
        this.component = object.get_component();
        this.circuitDiagram = circuitDiagram;

        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray {
        if (link != null) {
            circuitDiagram.removeLink(link);
            linkAndComponentAndEndpointAndPortArray.removeLink(link);
        }

        if (component != null) {
            circuitDiagram.removeComponent(component);
            linkAndComponentAndEndpointAndPortArray.removeComponent(component);
        }

        return linkAndComponentAndEndpointAndPortArray;
    }

    public function redo():LinkAndComponentAndEndpointAndPortArray {
        execute();
        return linkAndComponentAndEndpointAndPortArray;
    }

    public function execute():Void {
        if (link != null) {
            circuitDiagram.addLink(link);
            linkAndComponentAndEndpointAndPortArray.addLink(link);
        }

        if (component != null) {
            circuitDiagram.addComponent(component);
            linkAndComponentAndEndpointAndPortArray.addComponent(component);
        }
    }
}
