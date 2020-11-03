package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.enumeration.Orientation;

/**
 * ...
 * @author AdvaitTrivedi
 */
class RotateComponentCommand extends AbstractCommand 
{
	var component: Component;

	public function new(circuitDiagram: CircuitDiagramI, component: Component) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.component = component;
	}
	
	override public function execute() : Void {
		switch(this.component.get_orientation()) {
			case Orientation.EAST: component.set_orientation(Orientation.SOUTH);
			case Orientation.SOUTH: component.set_orientation(Orientation.WEST);
			case Orientation.WEST: component.set_orientation(Orientation.NORTH);
			case Orientation.NORTH: component.set_orientation(Orientation.EAST);
			default: component.set_orientation(Orientation.EAST);
		}
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		switch(this.component.get_orientation()) {
			case Orientation.EAST: component.set_orientation(Orientation.NORTH);
			case Orientation.SOUTH: component.set_orientation(Orientation.EAST);
			case Orientation.WEST: component.set_orientation(Orientation.SOUTH);
			case Orientation.NORTH: component.set_orientation(Orientation.WEST);
			default: component.set_orientation(Orientation.EAST);
		}
	};
}