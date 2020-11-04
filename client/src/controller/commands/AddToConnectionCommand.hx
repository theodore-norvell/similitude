package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Connectable;
import model.component.Connection;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddToConnectionCommand extends AbstractCommand  implements CommandI
{
	var newConnection: Connection;
	var oldConnection: Connection;
	var connectable: Connectable;

	public function new(circuitDiagram: CircuitDiagramI, connection: Connection, connectable: Connectable) 
	{
		super(circuitDiagram);
		this.newConnection = connection;
		this.connectable = connectable;
		this.oldConnection = connectable.getConnection() ;
	}
	
	public function execute() : Void {
		this.newConnection.connect(this.connectable);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.oldConnection.connect(this.connectable);
	};
}