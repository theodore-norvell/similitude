package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.type.Type.LinkAndComponentArray;
import com.mun.type.Type.Object;
/**
* add command is used to process the add operation
* @author wanhui
**/
class AddCommand implements Command {
    var link:Link;
    var component:Component;
    var circuitDiagram:CircuitDiagramI;
    var linkAndComponentArray:LinkAndComponentArray = {"linkArray":new Array<Link>(), "componentArray":new Array<Component>()};

    public function new(object:Object, circuitDiagram:CircuitDiagramI) {
        this.link = object.link;
        this.component = object.component;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():LinkAndComponentArray {
        if (link != null) {
            circuitDiagram.removeLink(link);
            linkAndComponentArray.linkArray.remove(link);
        }

        if (component != null) {
            circuitDiagram.removeComponent(component);
            linkAndComponentArray.componentArray.remove(component);
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
            linkAndComponentArray.linkArray.push(link);
        }

        if (component != null) {
            circuitDiagram.addComponent(component);
            linkAndComponentArray.componentArray.push(component);
        }
    }
}
