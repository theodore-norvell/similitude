package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
/**
* delete command
* @author wanhui
**/
class DeleteCommand implements Command {
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;

    public function new(linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, circuitDiagram:CircuitDiagramI) {
        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();

        this.linkAndComponentAndEndpointAndPortArray = linkAndComponentArray;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray {
        if (linkAndComponentAndEndpointAndPortArray.getLinkIteratorLength() != 0) {
            for (i in linkAndComponentAndEndpointAndPortArray.get_linkIterator()) {
                circuitDiagram.addLink(i);
            }
        }

        if (linkAndComponentAndEndpointAndPortArray.getComponentIteratorLength() != 0) {
            for (i in linkAndComponentAndEndpointAndPortArray.get_componentIterator()) {
                circuitDiagram.addComponent(i);
            }
        }

        return linkAndComponentAndEndpointAndPortArray;
    }

    public function redo():LinkAndComponentAndEndpointAndPortArray {
        execute();
        return linkAndComponentAndEndpointAndPortArray;
    }

    public function execute():Void {
        for (i in linkAndComponentAndEndpointAndPortArray.get_linkIterator()) {
            circuitDiagram.deleteLink(i);
        }

        for (i in linkAndComponentAndEndpointAndPortArray.get_componentIterator()) {
            circuitDiagram.deleteComponent(i);
        }

    }
}
