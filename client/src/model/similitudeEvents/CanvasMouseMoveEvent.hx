package model.similitudeEvents;

import type.HitObject;
/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasMouseMoveEvent extends CanvasMouseInteractionEvent
{
	public function new(objectsHit: Array<HitObject>) 
	{
		this.objectsHit = objectsHit;
		this.eventTypes = EventTypesEnum.CANVAS_MOUSE_MOVE;
	}
}