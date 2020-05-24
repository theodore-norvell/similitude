package controller.commandManager;

import model.component.CircuitDiagramI;
import model.selectionModel.SelectionModel;
import haxe.Serializer;
import haxe.Unserializer;

/**
 * ...
 * @author AdvaitTrivedi
 */
class ClearSelectionCommand extends AbstractCommand
{
	var selectionModel: SelectionModel;
	var copySelectionModel: String;
	
	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel, ?commandUID: String) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		this.copySelectionModel = Serializer.run(selectionModel);
		this.commandUID = commandUID;
	}
	
	override public function execute() : Void {
		this.selectionModel.clearSelection();
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		var selection = Unserializer.run(this.copySelectionModel);
		trace("Selection :: ", selection);
		this.selectionModel = cast(selection, SelectionModel);
	};
}