package model.values.instantaneousValues.scalarValues.errorValues;

import model.values.instantaneousValues.scalarValues.AbstractScalarValue;

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
	
	function logicOperation(instantaneousValue:InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, VectorValueI)) {
			var instantaneousValueArray = new Array<InstantaneousValueI>();
			var vectorValue = Std.downcast(instantaneousValue, VectorValue);
			for (value in vectorValue) {
				instantaneousValueArray.push(this);
			}
			return new VectorValue(instantaneousValueArray);
		}
		return this;
	}
	
	@:allow(model.gates.AND)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	override public function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}
	
	@:allow(model.gates.OR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}
	
	@:allow(model.gates.NOT)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function not():InstantaneousValueI 
	{
		return this;
	}
	
	@:allow(model.gates.XOR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	public function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}
	
	public function getErrorMessage(): String {
		return this.error;
	}
	
}