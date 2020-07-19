package model.values.instantaneousValues.scalarValues.errorValues;

import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.scalarValues.AbstractScalarValue;
import model.values.instantaneousValues.vectorValues.VectorValue;
import model.values.instantaneousValues.vectorValues.VectorValueI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class StringErrorValue extends AbstractScalarValue implements ErrorValueI
{

	var error: String;
	
	public function new(error: String) 
	{
		this.error = error;
	}
	
	override public function toString():String {
		return "X"; 
	}
	
	override public function setDrawingStrategy(stratFactory: InstantaneousStratFactoryI) : Void {
		this.drawingStrategy = stratFactory.getErrorStrat();
	}
	
	override public function draw(context: CanvasRenderingContext2D, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void {
		// TODO : Each error method has it's own drawing implementation (Maybe?). Look into it.
	}
	
	function logicOperation(instantaneousValue:InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, VectorValueI)) {
			var instantaneousValueArray = new Array<InstantaneousValueI>();
			var vectorValue: VectorValue = Std.downcast(instantaneousValue, VectorValue);
			for (value in vectorValue) {
				instantaneousValueArray.push(this);
			}
			return new VectorValue(instantaneousValueArray);
		}
		return this;
	}

	override public function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}

	override public function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}

	override public function not():InstantaneousValueI 
	{
		return this;
	}
	
	override public function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}
	
	public function getErrorMessage(): String {
		return this.error;
	}
	
}