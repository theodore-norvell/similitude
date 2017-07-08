package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.type.LinkAndComponentArray;
/**
* Copy command
* @author wanhui
**/
class CopyCommand implements Command {
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentArray;

    public function new(linkAndComponentArray:LinkAndComponentArray, circuitDiagram:CircuitDiagramI) {
        linkAndComponentArray = new LinkAndComponentArray();

        this.circuitDiagram = circuitDiagram;
        this.linkAndComponentArray = linkAndComponentArray;
    }

    public function undo():LinkAndComponentArray {
        circuitDiagram.clearCopyStack();
        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentArray {
        execute();
        return linkAndComponentArray;
    }

    public function execute():Void {
        if (linkAndComponentArray.get_linkArray() != null) {
            for (i in linkAndComponentArray.get_linkArray()) {
                circuitDiagram.pushLinkToCopyStack(i);
            }
        }

        if (linkAndComponentArray.get_componentArray() != null) {
            for (i in linkAndComponentArray.get_componentArray()) {
                circuitDiagram.pushComponentToCopyStack(i);
            }
        }
    }
}
