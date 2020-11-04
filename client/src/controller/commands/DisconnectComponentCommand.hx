package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.component.Connection;
import model.component.Port;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DisconnectComponentCommand extends AbstractCommand  implements CommandI
{
	var component: Component;
	var connectionPortMap: Map<Connection, Port> = new Map<Connection, Port>();

	public function new(component: Component) 
	{
		super( component.get_CircuitDiagram() ) ;
		this.component = component;
	}
	
	public function execute() : Void {
		for (port in this.component.get_ports()) {
			this.connectionPortMap.set(port.getConnection(), port);
			port.disconnect();
		}
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		for (connection => port in this.connectionPortMap) {
			connection.connect(port);
		}
	};
}