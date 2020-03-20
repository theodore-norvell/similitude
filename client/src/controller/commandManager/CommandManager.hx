package controller.commandManager;
import haxe.ds.GenericStack;

/**
 * ...
 * @author AdvaitTrivedi
 */
class CommandManager 
{
	var undoStack = new GenericStack<CommandI>();
	var redoStack = new GenericStack<CommandI>();
	
	public function new () {}
	
	public function executeCommand(command: CommandI) : Void {
		command.execute();
		undoStack.add(command);
	}
	
	public function undoCommand() : Void {
		var undoCommand = undoStack.pop();
		undoCommand.undo();
		redoStack.add(undoCommand);
	}
	
	public function redoCommand() : Void {
		var redoCommand = redoStack.pop();
		redoCommand.redo();
		undoStack.add(redoCommand);
	}
}