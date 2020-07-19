package model.values.instantaneousValues.scalarValues;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.vectorValues.VectorValue;

/**
 * ...
 * @author AdvaitTrivedi
 */
class HighValue extends AbstractScalarValue
{
	public function new() 
	{
		
	}
	
	override public function toString():String 
	{
		return "H";
	}
	
	override public function setDrawingStrategy(stratFactory: InstantaneousStratFactoryI) : Void {
		this.drawingStrategy = stratFactory.getHighStrat();
	}

	override public function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return instantaneousValue;
	}
	
	override public function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var instantaneousValueArray = new Array<InstantaneousValueI>();
			var vectorValue = Std.downcast(instantaneousValue, VectorValue);
			for (value in vectorValue) {
				instantaneousValueArray.push(this);
			}
			return new VectorValue(instantaneousValueArray);
		} else {
			return this;
		}
	}
	
	override public function not():InstantaneousValueI 
	{
		return Std.downcast(ScalarValueSingletons.LOW, LowValue);
	}
	
	override public function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var instantaneousValueArray = new Array<InstantaneousValueI>();
			var vectorValue = Std.downcast(instantaneousValue, VectorValue);
			for (value in vectorValue) {
				instantaneousValueArray.push(this.xor(value));
			}
			return new VectorValue(instantaneousValueArray);
		} else {
			if (Std.is(instantaneousValue, HighValue)) {
				return new LowValue();
			} else if (Std.is(instantaneousValue, LowValue)) {
				return this;
			} else {
				return instantaneousValue;
			}
		}
	}
}