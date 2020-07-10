package model.values.instantaneousValues.vectorValues;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.scalarValues.ScalarValueI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class VectorValue implements VectorValueI 
{
	var vector : Array<InstantaneousValueI> = new Array<InstantaneousValueI>();

	public function new() 
	{
		
	}
	
	
	/* INTERFACE model.values.VectorValueI */
	
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function fromArray(instanteousValues: Array<InstantaneousValueI>) : VectorValueI {
		for (value in instanteousValues) {
			this.push(value);
		}
		
		return this;
	}
	
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function push(instantaneousValue:InstantaneousValueI, ?index:Int = 0):Void 
	{
		this.vector.insert(index, instantaneousValue);
	}
	
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function removeFrom(?index:Int = 0):InstantaneousValueI 
	{
		if (index == 0) {
			return this.vector.shift();
		}
		
		if (index > this.length()) {
			throw "Invalid index";
		}
		
		var valuePopped = this.vector[index];
		this.vector.remove(valuePopped);
		return valuePopped;
	}
	
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function concat(vectorValue:VectorValueI):Void 
	{
		for (value in vectorValue) {
			this.push(value);
		}
	}
	
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function slice(?startIndex:Int = 0, ?endIndex:Int):VectorValueI 
	{
		if (endIndex > this.length()) {
			throw "Invalid end index";
		}
		
		var newVector = new VectorValue();
		return newVector.fromArray(this.vector.slice(startIndex, endIndex));
	}
	
	public function length():Int 
	{
		return this.vector.length;	
	}
	
	public function depth():Int 
	{
		// I need a better explaination of this.
		// TODO : Implement
		return 0;
	}
	
	public function iterator():Iterator<ScalarValueI> 
	{
		return this.vector.iterator();
	}
	
	public function toString() : String {
		var string = "[";
		for (value in this.vector) {
			string += value.toString() + ((this.vector.indexOf(value) == this.length()-1) ? "" : ",");
		}
		string += "]";
		return string;
	}
	
	@:allow(model.gates.AND)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function and(instantaneousValue: InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, ScalarValueI)) {
			return instantaneousValue.and(this);
		} else {
			// Vector-Vector AND case
			// TODO : Understand this better
			return this;
		}
	}
	
	@:allow(model.gates.OR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function or(instantaneousValue: InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, ScalarValueI)) {
			return instantaneousValue.or(this);
		} else {
			// Vector-Vector AND case
			// TODO : Understand this better
			return this;
		}
	}
	
	@:allow(model.gates.NOT)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function not() : InstantaneousValueI {
		var vectorValue = new VectorValue();
		for (value in this.vector) {
			vectorValue.push(value.not());
		}
		return vectorValue;
	}
	
	@a:allow(model.gates.XOR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function xor(instantaneousValue: InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, ScalarValueI)) {
			return instantaneousValue.xor(this);
		} else {
			// Vector-Vector AND case
			// TODO : Understand this better
			return this;
		}
	}
}