package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.CircuitElement;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddToSelectionCommand extends AbstractCommand
{
	var circuitElement: CircuitElement;
	var selectionModel: SelectionModel;
	
	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel, circuitElement: CircuitElement) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		this.circuitElement = circuitElement;
	}
	
	override public function execute() : Void {
		this.selectionModel.addCircuitElement(this.circuitElement);
		trace("Adding to selection model ::", this.selectionModel);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.selectionModel.removeCircuitElement(this.circuitElement);
	};
}