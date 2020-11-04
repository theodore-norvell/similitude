package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class MoveSelectionCommand extends AbstractCommand implements CommandI
{
	var selectionModel: SelectionModel;
	var oldX: Float;
	var oldY: Float;
	var newX: Float;
	var newY: Float;
	
	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel, oldX: Float, oldY: Float, newX: Float, newY: Float) 
	{
		super(circuitDiagram);
		this.selectionModel = selectionModel;
		this.oldX = oldX;
		this.oldY = oldY;
		this.newX = newX;
		this.newY = newY;
	}
	
	public function execute() : Void {
		this.selectionModel.moveComponentsAndLinks(newX - oldX, newY - oldY);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.selectionModel.moveComponentsAndLinks(oldX - newX, oldY - newY);
	};
}