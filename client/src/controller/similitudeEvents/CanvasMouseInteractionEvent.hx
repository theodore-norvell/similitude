package controller.similitudeEvents;

import type.HitObject;

/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasMouseInteractionEvent extends AbstractSimilitudeEvent {
	public var x(default, null):Float;
	public var y(default, null):Float;
	public var objectsHit(default, null):Array<HitObject>;

	public function new(eventType: EventTypesEnum, x:Float, y:Float, objectsHit:Array<HitObject>) {
		super( eventType ) ;
		this.x = x;
		this.y = y;
		this.objectsHit = objectsHit;
	}

	/**
	 * Wil return true if more than 0 objects are hit.
	 * @return Boolean
	 */
	public function didObjectsGetHit():Bool {
		return this.objectsHit.length > 0;
	}
}
