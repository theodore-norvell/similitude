package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Connection;

/**
 * ...
 * @author AdvaitTrivedi
 */
class SwapConnectionsCommand extends AbstractCommand 
{
	var connection1: Connection;
	var connection2: Connection;

	public function new(circuitDiagram: CircuitDiagramI, connection1: Connection, connection2: Connection) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.connection1 = connection1;
		this.connection2 = connection2;
	}
	
	override public function execute() : Void {
		var temp = connection1 ; 
		this.connection1 = this.connection2; 
		this.connection2 = temp;
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		var temp = connection2 ; 
		this.connection2 = this.connection1; 
		this.connection1 = temp;
	};
}