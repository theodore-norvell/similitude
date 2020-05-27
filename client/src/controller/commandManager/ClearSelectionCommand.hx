package controller.commandManager;

import model.component.CircuitDiagramI;
import model.selectionModel.SelectionModel;
// import haxe.Serializer;
// import haxe.Unserializer;

/**
 * ...
 * @author AdvaitTrivedi
 */
class ClearSelectionCommand extends AbstractCommand
{
	var selectionModel: SelectionModel;
	// var copySelectionModel: String;
	
	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		// The serialization is causing an infinite recursion.
		// Note that serialization is not a great way to do this
		// anyway.  See my comments in undo below. TSN
		// trace( "Starting serialization. ") ;
		// this.copySelectionModel = Serializer.run(selectionModel);
		// trace( "Done serialization. ") ;
	}
	
	override public function execute() : Void {
		this.selectionModel.clearSelection();
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		//var selection: SelectionModel = Unserializer.run(this.copySelectionModel);
		// trace("Selection :: ", selection);
		// This isn't going to work because it doesn't add
		// things back into the selection model object, it simply
		// changes the value of the field to a new object.  TSN
		// this.selectionModel = cast(selection, SelectionModel);
	};
}