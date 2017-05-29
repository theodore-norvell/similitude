package com.mun.controller.command;

import com.mun.model.component.CircuitDiagramI;
/**
* command manager used to manage those command
* @author wanhui
**/
class CommandManager {
    var undoStack:Array<Command> = new Array<Command>();
    var redoStack:Array<Command> = new Array<Command>();
    var circuitDiagram:CircuitDiagramI;

    public function new(circuitDiagram:CircuitDiagramI) {
        this.circuitDiagram = circuitDiagram;
    }

    public function execute(command:Command):Void {
        command.execute();
        undoStack.push(command);

        //set the redo stack empty
        if (redoStack.length != 0) {
            for (i in 0...redoStack.length) {
                redoStack.pop();
            }
        }
    }

    public function undo():Bool {
        if (undoStack.length == 0) {
            return false;
        }

        var command:Command = undoStack.pop();
        command.undo();
        redoStack.push(command);
        return true;
    }

    public function redo():Bool {
        if (redoStack.length == 0) {
            return false;
        }

        var command:Command = redoStack.pop();
        command.redo();
        undoStack.push(command);
        return true;
    }
}
