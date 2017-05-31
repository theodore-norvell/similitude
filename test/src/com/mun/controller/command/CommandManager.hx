package com.mun.controller.command;

import com.mun.type.Type.Object;
/**
* command manager used to manage those command
* @author wanhui
**/
class CommandManager {
    var undoStack:Array<Command> = new Array<Command>();
    var redoStack:Array<Command> = new Array<Command>();
    var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
    //most of actions will result add lots of commands into stack. such as
    //moveing component, link. therefore, need a flag to record the first step of moving
    //this varible only controlled by mouse down and mouse up action, both of them will reset this flag
    var recordFlag:Bool = false;

    public function new() {
    }

    public function execute(command:Command):Void {
        command.execute();
        if(!recordFlag){//if record falg == false, means has not push anything.
            undoStack.push(command);
        }
        recordFlag = true;
        //set the redo stack empty
        if (redoStack.length != 0) {
            for (i in 0...redoStack.length) {
                redoStack.pop();
            }
        }
    }

    public function undo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        if (undoStack.length == 0) {
            return object;
        }
        var command:Command = undoStack.pop();
        object = command.undo();
        redoStack.push(command);
        return object;
    }

    public function redo():Object {
        object = {"link":null,"component":null,"endPoint":null, "port":null};
        if (redoStack.length == 0) {
            return object;
        }

        var command:Command = redoStack.pop();
        object = command.redo();
        undoStack.push(command);
        return object;
    }

    public function recordFlagRest(){
        recordFlag = false;
    }

    public function getUndoStackSize():Int{
        return undoStack.length;
    }

    public function getRedoStackSize():Int{
        return redoStack.length;
    }
}
