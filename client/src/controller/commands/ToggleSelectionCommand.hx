package controller.commands ;

import commandManager.CommandI ;
import assertions.Assert ;
import model.component.CircuitDiagramI;
import model.component.CircuitElement;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class ToggleSelectionCommand extends AbstractCommand implements CommandI
{
	var circuitElement: CircuitElement;
	var selectionModel: SelectionModel;
	
	public function new(selectionModel: SelectionModel, circuitElement: CircuitElement) 
	{
		super( circuitElement.get_CircuitDiagram() ) ;
		this.selectionModel = selectionModel;
		this.circuitElement = circuitElement;
	}
	
	public function execute() : Void {
		this.selectionModel.toggleCircuitElement(this.circuitElement);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.selectionModel.toggleCircuitElement(this.circuitElement);
	};
}