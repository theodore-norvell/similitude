package model.values.instantaneousValues.displayStrategies.digitalWaveformStrategies;

import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.displayStrategies.InstantaneousDrawStrategyI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DontCareDigitalWaveStrat implements DigitalWaveformStratI 
{

	public function new() 
	{
		
	}
	
	
	/* INTERFACE model.values.instantaneousValues.displayStrategies.InstantaneousDrawStrategyI */
	
	public function draw(context:CanvasRenderingContext2D, startX:Float, startY:Float, timeMagnitude:Float, ?continuation:Bool = true):Void 
	{
		
	}
	
}