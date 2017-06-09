package com.mun.controller.command;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.model.component.CircuitDiagramI;
import com.mun.type.Type.LinkAndComponentArray;
/**
* delete command
* @author wanhui
**/
class DeleteCommand implements Command {
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentArray = {"linkArray":new Array<Link>(), "componentArray":new Array<Component>()};

    public function new(linkAndComponentArray:LinkAndComponentArray, circuitDiagram:CircuitDiagramI) {
        this.linkAndComponentArray = linkAndComponentArray;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentArray {
        if (linkAndComponentArray.linkArray != null) {
            for(i in linkAndComponentArray.linkArray){
                circuitDiagram.addLink(i);
            }
        }

        if (linkAndComponentArray.componentArray != null) {
            for(i in linkAndComponentArray.componentArray){
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
        if (linkAndComponentArray.linkArray != null) {
            for(i in linkAndComponentArray.linkArray){
                circuitDiagram.deleteLink(i);
            }
        }

        if (linkAndComponentArray.componentArray != null) {
            for(i in linkAndComponentArray.componentArray){
                circuitDiagram.deleteComponent(i);
            }
        }
    }
}
