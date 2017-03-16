package com.mun.controller.command;
import com.mun.controller.circuitDiagram.StaticCircuitDiagram;
import com.mun.model.component.CircuitDiagram;
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
    var circuitDiagram:CircuitDiagram;

    public function new(objectArray:ObjectArray, circuitDiagram:CircuitDiagram) {
        this.linkArray = objectArray.linkArray;
        this.componentArray = objectArray.componentArray;
        this.circuitDiagram = circuitDiagram;
    }

    public function undo():Void {
        circuitDiagram.clearCopyStack();
    }

    public function redo():Void {
        execute();
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
