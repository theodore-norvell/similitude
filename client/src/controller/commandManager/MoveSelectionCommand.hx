package controller.commandManager;
import model.component.CircuitDiagramI;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class MoveSelectionCommand extends AbstractCommand
{
	var selectionModel: SelectionModel;
	var oldX: Float;
	var oldY: Float;
	var newX: Float;
	var newY: Float;
	
	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel, oldX: Float, oldY: Float, newX: Float, newY: Float, ?commandUID: String) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		this.oldX = oldX;
		this.oldY = oldY;
		this.newX = newX;
		this.newY = newY;
		this.commandUID = commandUID;
	}
	
	override public function execute() : Void {
		this.selectionModel.moveComponentsAndLinks(newX - oldX, newY - oldY);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.selectionModel.moveComponentsAndLinks(oldX - newX, oldY - newY);
	};
}