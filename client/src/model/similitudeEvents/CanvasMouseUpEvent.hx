package model.similitudeEvents;

import type.HitObject;
/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasMouseUpEvent extends CanvasMouseInteractionEvent
{
	public function new(objectsHit: Array<HitObject>) 
	{
		this.objectsHit = objectsHit;
		this.eventTypes = EventTypesEnum.CANVAS_MOUSE_UP;
	}
}