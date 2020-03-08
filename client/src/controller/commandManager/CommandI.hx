package controller.commandManager;

/**
 * @author AdvaitTrivedi
 */
interface CommandI 
{
	public function execute(): Void;
	public function undo(): Void;
	public function redo(): Void;
}