package model.similitudeEvents;

/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasPanEvent extends AbstractSimilitudeEvent
{
	
	public var xPan: Float = 0;
	public var yPan: Float = 0;

	public function new() 
	{
		this.eventTypes = EventTypesEnum.CANVAS_PAN;
	}
	
}