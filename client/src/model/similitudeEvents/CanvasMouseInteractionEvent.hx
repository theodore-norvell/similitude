package model.similitudeEvents;
import type.HitObject;

/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasMouseInteractionEvent extends AbstractSimilitudeEvent
{
	public var xPosition: Float;
	public var yPosition: Float;
	var objectsHit: Array<HitObject>;
	
	/**
	 * 
	 * @return
	 */
	public function getObjectsHit(): Array<HitObject> {
		return this.objectsHit;
	}
	
	/**
	 * Wil return true if more than 0 objects are hit.
	 * @return Boolean
	 */
	public function didObjectsGetHit(): Bool {
		return this.objectsHit.length > 0;
	}
}