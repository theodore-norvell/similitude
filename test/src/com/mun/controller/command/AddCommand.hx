package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.type.Type.Object;
/**
* add command is used to process the add operation
* @author wanhui
**/
class AddCommand implements Command {
    var link:Link;
    var component:Component;
    var circuitDiagram:CircuitDiagramI;
    var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};

    public function new(object:Object, circuitDiagram:CircuitDiagramI) {
        this.link = object.link;
        this.component = object.component;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        if (link != null) {
            circuitDiagram.removeLink(link);
        }

        if (component != null) {
            circuitDiagram.removeComponent(component);
        }

        return object;
    }

    public function redo():Object {
        execute();
        object = {"link":link,"component":component,"endPoint":null, "port":null};
        return object;
    }

    public function execute():Void {
        if (link != null) {
            circuitDiagram.addLink(link);
        }

        if (component != null) {
            circuitDiagram.addComponent(component);
        }
    }
}
