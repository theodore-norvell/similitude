package model.values.instantaneousValues.scalarValues;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.vectorValues.VectorValue;

/**
 * ...
 * @author AdvaitTrivedi
 */
class HighValue implements ScalarValueI 
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
		return "H";
	}
	
	function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var vectorValue = new VectorValue();
			for (value in instantaneousValue) {
				vectorValue.push(this.and(value));
			}
			return vectorValue;
		} else {
			if (Std.is(instantaneousValue, HighValue)) {
				return this;
			} else {
				return instantaneousValue;
			}
		}
	}
	
	function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this;
	}
	
	function not(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return new LowValue();
	}
	
}