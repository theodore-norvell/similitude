package com.mun.controller.command;

import com.mun.type.LinkAndComponentArray;
/**
* command manager used to manage those command
* @author wanhui
**/
class CommandManager {
    var undoStack:Array<Command> = new Array<Command>();
    var redoStack:Array<Command> = new Array<Command>();
    var linkAndComponentArray:LinkAndComponentArray;
    //most of actions will result add lots of commands into stack. such as
    //moveing component, link. therefore, need a flag to record the first step of moving
    var recordFlag:Bool = false;

    public function new() {
        linkAndComponentArray = new LinkAndComponentArray();
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

    public function undo():LinkAndComponentArray {
        if (undoStack.length == 0) {
            return linkAndComponentArray;
        }
        var command:Command = undoStack.pop();
        linkAndComponentArray = command.undo();
        redoStack.push(command);
        return linkAndComponentArray;
    }

    public function redo():LinkAndComponentArray {
        if (redoStack.length == 0) {
            return linkAndComponentArray;
        }
        var command:Command = redoStack.pop();
        linkAndComponentArray = command.redo();
        undoStack.push(command);
        return linkAndComponentArray;
    }

    public function recordFlagRest(){
        recordFlag = false;
    }

    public function recordFlagSetTrue(){
        recordFlag = true;
    }

    public function getUndoStackSize():Int{
        return undoStack.length;
    }

    public function getRedoStackSize():Int{
        return redoStack.length;
    }
}
