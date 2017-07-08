package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.type.LinkAndComponentArray;
/**
* delete command
* @author wanhui
**/
class DeleteCommand implements Command {
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentArray;

    public function new(linkAndComponentArray:LinkAndComponentArray, circuitDiagram:CircuitDiagramI) {
        linkAndComponentArray = new LinkAndComponentArray();

        this.linkAndComponentArray = linkAndComponentArray;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentArray {
        if (linkAndComponentArray.get_linkArray() != null) {
            for (i in linkAndComponentArray.get_linkArray()) {
                circuitDiagram.addLink(i);
            }
        }

        if (linkAndComponentArray.get_componentArray() != null) {
            for (i in linkAndComponentArray.get_componentArray()) {
                circuitDiagram.addComponent(i);
            }
        }

        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentArray {
        execute();
        return linkAndComponentArray;
    }

    public function execute():Void {
        for (i in linkAndComponentArray.get_linkArray()) {
            circuitDiagram.deleteLink(i);
        }

        for (i in linkAndComponentArray.get_componentArray()) {
            circuitDiagram.deleteComponent(i);
        }

    }
}
