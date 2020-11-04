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
class AddComponentCommand extends AbstractCommand  implements CommandI
{
	var component: Component;
	
	public function new(component: Component) 
	{
		super(component.get_CircuitDiagram());
		this.component = component;
	}
	
	public function execute() : Void {
		this.circuitDiagram.addComponent(this.component);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.circuitDiagram.deleteComponent(this.component);
	};	
	
}
