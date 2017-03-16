package com.mun.controller.command;
/**
* command manager used to manage those command
* @author wanhui
**/
import com.mun.model.component.CircuitDiagram;
class CommandManager {
    var undoStack:Array<Command> = new Array<Command>();
    var redoStack:Array<Command> = new Array<Command>();
    var undoCounter:Int = -1;//set how many command can store

    public function new(circuitDiagram:CircuitDiagram) {
        this.undoCounter = 10;//undo 10 steps
        this.circuitDiagram = circuitDiagram;
    }

    public function execute(command:Command):Void {
        command.execute();
        undoStack.push(command);

        //make sure only 10 steps stores in the stack
        if (undoCounter != -1 && undoStack.length > undoCounter) {
            undoStack.remove(0);
        }

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
