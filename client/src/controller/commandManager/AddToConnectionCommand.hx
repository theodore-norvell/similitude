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
	var newConnection: Connection;
	var oldConnection: Connection;
	var connectable: Connectable;

	public function new(circuitDiagram: CircuitDiagramI, connection: Connection, connectable: Connectable) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.newConnection = connection;
		this.connectable = connectable;
		this.oldConnection = connectable.getConnection() ;
	}
	
	override public function execute() : Void {
		this.newConnection.connect(this.connectable);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.oldConnection.connect(this.connectable);
	};
}