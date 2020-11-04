package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Endpoint;
import type.Coordinate;

/**
 * ...
 * @author AdvaitTrivedi
 */
class MoveEndpointCommand extends AbstractCommand implements CommandI
{
	var endpoint: Endpoint;
	var previousWorldCoordinates: Coordinate;
	var newWorldCoordinates: Coordinate;
	
	public function new(circuitDiagram: CircuitDiagramI, endpoint: Endpoint, newCoordinates: Coordinate) 
	{
		super(circuitDiagram);
		this.endpoint = endpoint;
		this.previousWorldCoordinates = new Coordinate(this.endpoint.get_xPosition(), this.endpoint.get_yPosition());
		this.newWorldCoordinates = newCoordinates;
	}
	
	public function execute() : Void {
		this.endpoint.moveTo(this.newWorldCoordinates);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.endpoint.moveTo(this.previousWorldCoordinates);
	};		
}