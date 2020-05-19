package controller.commandManager;

import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class ClearSelectionCommand extends AbstractCommand
{
	var selectedComponents = new Array<Component>();
	var selectedLinks = new Array<Link>();
	var selectedPorts = new Array<Port>();
	var selectedEndpoints = new Array<Endpoint>();
	var selectionModel: SelectionModel;
	var copySelectionModel: SelectionModel;
	
	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		this.copySelectionModel = Reflect.
	}
	
	override public function execute() : Void {
		this.selectionModel.addCircuitElement(this.circuitElement);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.selectionModel.removeCircuitElement(this.circuitElement);
	};
}