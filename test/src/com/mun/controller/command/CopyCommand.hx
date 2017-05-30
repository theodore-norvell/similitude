package com.mun.controller.command;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.type.Type.ObjectArray;
/**
* Copy command
* @author wanhui
**/
class CopyCommand implements Command {
    var linkArray:Array<Link>;
    var componentArray:Array<Component>;
    var circuitDiagram:CircuitDiagramI;
    var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};

    public function new(objectArray:ObjectArray, circuitDiagram:CircuitDiagramI) {
        this.linkArray = objectArray.linkArray;
        this.componentArray = objectArray.componentArray;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():Object {
        circuitDiagram.clearCopyStack();
        return object;
    }

    public function redo():Object {
        execute();
        return object;
    }

    public function execute():Void {
        if (linkArray != null) {
            for (i in 0...linkArray) {
                var link:Link = linkArray[i];
                circuitDiagram.pushLinkToCopyStack(link);
            }
        }

        if (componentArray != null) {
            for (i in 0...componentArray) {
                var component:Component = componentArray[i];
                circuitDiagram.pushComponentToCopyStack(component);
            }
        }
    }

    public function setCommandManager(commandManager:CommandManager):Void {
        this.commandManager = commandManager;
    }

}
