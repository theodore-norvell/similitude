package model.values.instantaneousValues.displayStrategies.digitalWaveformStrategies;
import js.html.CanvasRenderingContext2D;

/**
 * ...
 * @author AdvaitTrivedi
 */
class LowDigitalWaveStrat implements DigitalWaveformStratI 
{

	public function new() 
	{
		
	}
	
	
	/* INTERFACE model.values.instantaneousValues.displayStrategies.DigitalWaveformStrategies.DigitalWaveformStratI */
	
	public function draw(context: CanvasRenderingContext2D, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void
	{
		var xPosition = startX;
		var yPosition = startY;
		
		context.beginPath();
		context.moveTo(xPosition, yPosition);
		
		if (!continuation) {
			//context.lineTo(xPosition, yPosition);
			yPosition = yPosition - 15; // TODO : Put this number as a constant
			context.moveTo(xPosition, yPosition);
			yPosition = yPosition + 15; // TODO : Put this number as a constant
			context.lineTo(xPosition, yPosition);
			context.moveTo(xPosition, yPosition);
		}
		
		xPosition = xPosition + timeMagnitude; // you might want to manipulate this to adjust zoom factor
		
		context.lineTo(xPosition, yPosition);
		
		context.closePath();
		//context.strokeStyle = "red";
		
		context.stroke();
	}
	
}