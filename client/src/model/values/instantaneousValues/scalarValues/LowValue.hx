package model.values.instantaneousValues.scalarValues;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.vectorValues.VectorValue;

/**
 * ...
 * @author AdvaitTrivedi
 */
class LowValue extends AbstractScalarValue
{

	public function new() 
	{
		
	}
	
	override public function toString():String 
	{
		return "L";
	}
	
	@:allow(model.gates.AND)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var vectorValue = new Array<InstantaneousValueI>();
			for (value in Std.downcast(instantaneousValue, VectorValue)) {
				vectorValue.push(this);
			}
			return new VectorValue(vectorValue);
		} else {
			return this;
		}
	}
	
	@:allow(model.gates.OR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return instantaneousValue;
	}
	
	@:allow(model.gates.NOT)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function not():InstantaneousValueI 
	{
		return Std.downcast(ScalarValueSingletons.HIGH, HighValue);
	}
	
	@:allow(model.gates.XOR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.or(instantaneousValue);
	}
}