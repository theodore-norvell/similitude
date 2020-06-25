package controller.commandManager;
import assertions.Assert ;
import model.component.CircuitDiagramI;
import model.component.CircuitElement;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class ToggleSelectionCommand extends AbstractCommand
{
	var circuitElement: CircuitElement;
	var selectionModel: SelectionModel;
	
	public function new(selectionModel: SelectionModel, circuitElement: CircuitElement) 
	{
		this.selectionModel = selectionModel;
		this.circuitElement = circuitElement;
	}
	
	override public function execute() : Void {
		this.selectionModel.toggleCircuitElement(this.circuitElement);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.selectionModel.toggleCircuitElement(this.circuitElement);
	};
}