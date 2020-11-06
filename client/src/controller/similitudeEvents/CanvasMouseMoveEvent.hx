package controller.similitudeEvents;

import type.HitObject;
/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasMouseMoveEvent extends CanvasMouseInteractionEvent
{
	public function new(x:Float, y:Float, objectsHit:Array<HitObject>) 
	{
		super( CANVAS_MOUSE_MOVE, x, y, objectsHit ) ;
	}
}