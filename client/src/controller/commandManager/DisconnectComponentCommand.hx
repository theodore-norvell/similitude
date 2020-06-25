package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.component.Connection;
import model.component.Port;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DisconnectComponentCommand extends AbstractCommand 
{
	var component: Component;
	var connectionPortMap: Map<Connection, Port> = new Map<Connection, Port>();

	public function new(circuitDiagram: CircuitDiagramI, component: Component) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.component = component;
	}
	
	override public function execute() : Void {
		for (port in this.component.get_ports()) {
			this.connectionPortMap.set(port.getConnection(), port);
			port.disconnect();
		}
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		for (connection => port in this.connectionPortMap) {
			connection.connect(port);
		}
	};
}