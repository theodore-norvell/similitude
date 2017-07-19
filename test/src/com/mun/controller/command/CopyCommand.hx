package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
/**
* Copy command
* @author wanhui
**/
class CopyCommand implements Command {
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;

    public function new(linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, circuitDiagram:CircuitDiagramI) {
        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();

        this.circuitDiagram = circuitDiagram;
        this.linkAndComponentAndEndpointAndPortArray = linkAndComponentArray;
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray {
        circuitDiagram.clearCopyStack();
        return linkAndComponentAndEndpointAndPortArray;
    }

    public function redo():LinkAndComponentAndEndpointAndPortArray {
        execute();
        return linkAndComponentAndEndpointAndPortArray;
    }

    public function execute():Void {
        if (linkAndComponentAndEndpointAndPortArray.getLinkIteratorLength() != 0) {
            for (i in linkAndComponentAndEndpointAndPortArray.get_linkIterator()) {
                circuitDiagram.pushLinkToCopyStack(i);
            }
        }

        if (linkAndComponentAndEndpointAndPortArray.getComponentIteratorLength() != 0) {
            for (i in linkAndComponentAndEndpointAndPortArray.get_componentIterator()) {
                circuitDiagram.pushComponentToCopyStack(i);
            }
        }
    }
}
