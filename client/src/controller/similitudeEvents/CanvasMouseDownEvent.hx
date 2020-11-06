package controller.similitudeEvents;

import type.HitObject;
/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasMouseDownEvent extends CanvasMouseInteractionEvent
{
	public function new(x:Float, y:Float, objectsHit: Array<HitObject>) 
	{
		super( EventTypesEnum.CANVAS_MOUSE_DOWN, x, y, objectsHit ) ;
	}
}