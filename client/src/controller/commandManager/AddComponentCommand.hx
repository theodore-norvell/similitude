package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.gates.ComponentKind;
import model.enumeration.ORIENTATION;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddComponentCommand extends AbstractCommand
{
	var component: Component;
	
	public function new(circuitDiagram: CircuitDiagramI, component: Component) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.component = component;
	}
	
	override public function execute() : Void {
		this.circuitDiagram.addComponent(this.component);
	};
	
	override public function redo() : Void {
		this.execute();
	};
	
	override public function undo() : Void {
		this.circuitDiagram.deleteComponent(this.component);
	};	
	
}