package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.gates.ComponentKind;
import model.enumeration.Orientation;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddComponentCommand extends AbstractCommand
{
	var component: Component;
	
	public function new(component: Component) 
	{
		this.setCircuitDiagram(component.get_CircuitDiagram());
		this.component = component;
	}
	
	override public function execute() : Void {
		this.circuitDiagram.addComponent(this.component);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.circuitDiagram.deleteComponent(this.component);
	};	
	
}
