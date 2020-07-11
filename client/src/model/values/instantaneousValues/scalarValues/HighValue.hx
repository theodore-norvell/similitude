package model.values.instantaneousValues.scalarValues;
import model.values.instantaneousValues.InstantaneousValueI;
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
	
	public function toString():String 
	{
		return "H";
	}
	
	@:allow(model.gates.AND)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return instantaneousValue;
	}
	
	@:allow(model.gates.OR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var vectorValue = new VectorValue();
			for (value in instantaneousValue) {
				vectorValue.push(this);
			}
			return vectorValue;
		} else {
			return this;
		}
	}
	
	@:allow(model.gates.NOT)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function not():InstantaneousValueI 
	{
		return Std.downcast(ScalarValueSingletons.LOW, LowValue);
	}
	
	@:allow(model.gates.XOR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var vectorValue = new VectorValue();
			for (value in instantaneousValue) {
				vectorValue.push(this.xor(value));
			}
			return vectorValue;
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