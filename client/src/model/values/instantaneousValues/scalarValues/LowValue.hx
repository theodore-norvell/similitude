package model.values.instantaneousValues.scalarValues;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.vectorValues.VectorValue;

/**
 * ...
 * @author AdvaitTrivedi
 */
class LowValue implements ScalarValueI 
{

	public function new() 
	{
		
	}
	
	
	/* INTERFACE model.values.scalarValues.ScalarValueI */
	
	public function toVectorValue():VectorValueI 
	{
		
	}
	
	public function toString():String 
	{
		return "L";
	}
	
	@:allow(model.gates.AND)
	function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this;
	}
	
	@:allow(model.gates.OR)
	function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var vectorValue = new VectorValue();
			for (value in instantaneousValue) {
				vectorValue.push(this.or(value));
			}
			return vectorValue;
		} else {
			if (Std.is(instantaneousValue, LowValue)) {
				return this;
			} else {
				return instantaneousValue;
			}
		}
	}
	
	@:allow(model.gates.NOT)
	function not(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return new HighValue();
	}
	
}