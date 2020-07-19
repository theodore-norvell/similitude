package model.values.instantaneousValues.displayStrategies;
import js.html.CanvasRenderingContext2D;

/**
 * @author AdvaitTrivedi
 */
interface InstantaneousDrawStrategyI 
{
	public function draw(context: CanvasRenderingContext2D, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void;
}