package com.mun.controller.command;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.model.component.CircuitDiagramI;
import com.mun.type.Type.LinkAndComponentArray;
/**
* Copy command
* @author wanhui
**/
class CopyCommand implements Command {
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentArray = {"linkArray":new Array<Link>(), "componentArray":new Array<Component>()};

    public function new(linkAndComponentArray:LinkAndComponentArray, circuitDiagram:CircuitDiagramI) {
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
        if (linkAndComponentArray.linkArray != null) {
            for (i in linkAndComponentArray.linkArray) {
                circuitDiagram.pushLinkToCopyStack(i);
            }
        }

        if (linkAndComponentArray.componentArray != null) {
            for (i in linkAndComponentArray.componentArray) {
                circuitDiagram.pushComponentToCopyStack(i);
            }
        }
    }
}
