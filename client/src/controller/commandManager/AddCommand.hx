package controller.commandManager;

/**
 * An abstract class that allows to group common add functionality
 * We will be using add functions for each different component on the screen
 * 
 * @author AdvaitTrivedi
 */
class AddCommand extends AbstractCommand
{
	public function execute() : Void {};
	public function redo() : Void {};
	public function undo() : Void {};
}