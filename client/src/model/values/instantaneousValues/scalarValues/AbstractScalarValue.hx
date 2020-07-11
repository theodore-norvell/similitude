package model.values.instantaneousValues.scalarValues;
import assertions.Assert;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.vectorValues.VectorValue;
import model.values.instantaneousValues.vectorValues.VectorValueI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractScalarValue implements ScalarValueI 
{
	/* INTERFACE model.values.instantaneousValues.scalarValues.ScalarValueI */
	
	public function toVectorValue():VectorValueI 
	{
		return new VectorValue([this]);
	}
	
	public function toString():String {
		Assert.assert(false);
		return ""; 
	}
	
	@:allow(model.gates.AND)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI {
		Assert.assert(false);
		return this; 
		
	}
	
	@:allow(model.gates.OR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI {
		Assert.assert(false);
		return this; 
		
	}
	
	@:allow(model.gates.NOT)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function not():InstantaneousValueI {
		Assert.assert(false);
		return this; 
	}
	
	@:allow(model.gates.XOR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI {
		Assert.assert(false);
		return this; 
	}
	
}