package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Connectable;
import model.component.Connection;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddToConnectionCommand extends AbstractCommand 
{
	var connection: Connection;
	var connectable: Connectable;

	public function new(circuitDiagram: CircuitDiagramI, connection: Connection, connectable: Connectable) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.connection = connection;
		this.connectable = connectable;
	}
	
	override public function execute() : Void {
		this.connection.connect(this.connectable);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.connection.disconnect(this.connectable);
	};
}