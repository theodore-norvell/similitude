package controller.commandManager;
import haxe.ds.GenericStack;

/**
 * This is the command manager class that handles the commands/actions to be performed on the model in a proper fashio.
 * One invariant is that the currentCommandUID will always after an undo or redo be set back to "".
 * It keeps track of batch commands to undo/redo.
 * The "isBatch" flag can help handle the batch commands. If set true this class shall remember the first commands UID and carry it on for the rest of the commands.
 * @author AdvaitTrivedi
 */
class CommandManager 
{
	var currentCommandUID: String = "";
	var undoStack = new GenericStack<CommandI>();
	var redoStack = new GenericStack<CommandI>();
	
	public function new () {}
	
	/**
	 * Can handle batch commands too
	 * @param	command
	 * @param	isBatch
	 */
	public function executeCommand(command: CommandI, ?isBatch: Bool = false) : Void {
		if (isBatch) {
			// in case of a batch command the CommandManager should be capable of remembering the UID of the 1st command through
			if (this.currentCommandUID == "") {
				this.currentCommandUID = command.getCommandUID();
			} else {
				command.setCommandUID(this.currentCommandUID);
			}
			command.execute();
			undoStack.add(command);
			while( ! redoStack.isEmpty() ) redoStack.pop() ;
		} else {
			// this block shall ensure that the invariant is respected  in case it is not a batch command.
			command.execute();
			undoStack.add(command);
			while ( ! redoStack.isEmpty() ) redoStack.pop() ;
			this.currentCommandUID = "";
		}
	}
	
	/**
	 * Undo the first command and then check for batch commands with their UIDs, and undo them in a line.
	 * Reset the UID for the current batch back to "" to respect the invariant.
	 */
	public function undoCommand() : Void {
		if( ! undoStack.isEmpty() ) { 
			var undoCommand = undoStack.pop();
			undoCommand.undo();
			this.currentCommandUID = undoCommand.getCommandUID();
			redoStack.add(undoCommand);
		}
		
		while(! undoStack.isEmpty() && (this.currentCommandUID == undoStack.first().getCommandUID())) {
			var undoCommand = undoStack.pop();
			undoCommand.undo();
			redoStack.add(undoCommand);
		}
		
		this.currentCommandUID = "";
	}
	
	/**
	 * Redo the first command and then check for batch commands with their UIDs, and redo them in a line.
	 * Reset the UID for the current batch back to "" to respect the invariant.
	 */
	public function redoCommand() : Void {
		if( ! redoStack.isEmpty() ) {
			var redoCommand = redoStack.pop();
			redoCommand.redo();
			this.currentCommandUID = redoCommand.getCommandUID();
			undoStack.add(redoCommand); 
		}
		
		while( ! redoStack.isEmpty() && (this.currentCommandUID == redoStack.first().getCommandUID())) {
			var redoCommand = redoStack.pop();
			redoCommand.redo();
			undoStack.add(redoCommand);
		}
		
		this.currentCommandUID = "";
	}
}