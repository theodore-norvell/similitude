package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Endpoint;
import type.Coordinate;

/**
 * ...
 * @author AdvaitTrivedi
 */
class EditLinkCommand extends AbstractCommand
{
	var endpoint: Endpoint;
	var previousWorldCoordinates: Coordinate;
	var newWorldCoordinates: Coordinate;
	
	public function new(circuitDiagram: CircuitDiagramI, endpoint: Endpoint, newCoordinates: Coordinate) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.endpoint = endpoint;
		this.previousWorldCoordinates = new Coordinate(this.endpoint.get_xPosition(), this.endpoint.get_yPosition());
		this.newWorldCoordinates = newCoordinates;
	}
	
	override public function execute() : Void {
		this.endpoint.moveTo(this.newWorldCoordinates);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.endpoint.moveTo(this.previousWorldCoordinates);
	};		
}