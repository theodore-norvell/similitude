package model.values.instantaneousValues.vectorValues;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.scalarValues.ScalarValueI;

/**
 * Vectorised values.
 * Traversed as per the documentation for vectors. Array Indexing : Reverse : [2,1,0]. 2 denotes the end and 0 the beginning.
 * @author AdvaitTrivedi
 */
class VectorValue implements VectorValueI 
{
	var vector : Array<InstantaneousValueI> = new Array<InstantaneousValueI>();

	public function new(?instanteousValues: Array<InstantaneousValueI>) 
	{
		if (instanteousValues.length != 0) {
			for (instantaneousValue in instanteousValues) {
				this.vector.insert(0, instantaneousValue);
			}
		}
	}
	
	/* INTERFACE model.values.VectorValueI */
	
	public function length():Int 
	{
		return this.vector.length;
	}
	
	public function iterator():Iterator<InstantaneousValueI> 
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
	
	@:arrayAccess
	public function get(index: Int) : InstantaneousValueI {
		return this.vector[index];
	}
	
	public function and(instantaneousValue: InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, ScalarValueI)) {
			return instantaneousValue.and(this);
		} else {
			// Vector-Vector AND case
			// TODO : Understand this better
			return this;
		}
	}
	
	public function or(instantaneousValue: InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, ScalarValueI)) {
			return instantaneousValue.or(this);
		} else {
			// Vector-Vector OR case
			// TODO : Understand this better
			return this;
		}
	}
	
	public function not() : InstantaneousValueI {
		var instantaneousValueArray = new Array<InstantaneousValueI>();
		for (value in this.vector) {
			instantaneousValueArray.push(value.not());
		}
		return new VectorValue(instantaneousValueArray);
	}
	
	public function xor(instantaneousValue: InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, ScalarValueI)) {
			return instantaneousValue.xor(this);
		} else {
			// Vector-Vector XOR case
			// TODO : Understand this better
			return this;
		}
	}
	
	public function draw(context: CanvasRenderingContext2D, drawingStrategy: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void {
		// TODO : Think about drawing vectors
	}
}