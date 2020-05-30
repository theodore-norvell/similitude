package model.similitudeEvents;

/**
 * ...
 * @author AdvaitTrivedi
 */
class LinkAddEvent extends AbstractSimilitudeEvent
{
	public var addedAtX: Float = 0;
	public var addedAtY: Float = 0;
	
	public function new() 
	{
		this.eventTypes = EventTypesEnum.LINK_ADD;
	}
	
}