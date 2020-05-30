package model.similitudeEvents;
import model.component.Endpoint;
import type.Coordinate;

/**
 * ...
 * @author AdvaitTrivedi
 */
class LinkEditEvent extends AbstractSimilitudeEvent
{
	public var worldCoordinates: Coordinate;
	public var endpoint: Endpoint;
	
	public function new() 
	{
		this.eventTypes = EventTypesEnum.LINK_EDIT;
	}
	
}