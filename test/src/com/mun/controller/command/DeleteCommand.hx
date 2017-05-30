package com.mun.controller.command;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.type.Type.Object;
/**
* delete command
* @author wanhui
**/
class DeleteCommand implements Command {
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
            circuitDiagram.addLink(link);
            object.link = link;
        }

        if (component != null) {
            circuitDiagram.addComponent(component);
            object.component = component;
        }

        return object;
    }

    public function redo():Object {
        execute();
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        return object;
    }

    public function execute():Void {
        if (link != null) {
            circuitDiagram.deleteLink(link);
        }

        if (component != null) {
            circuitDiagram.deleteComponent(component);
        }
    }
}
