package model.values.instantaneousValues.vectorValues;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.scalarValues.ScalarValueI;

/**
 * @author AdvaitTrivedi
 */
interface VectorValueI extends InstantaneousValueI
{
	/**
	 * initializes the vector using an arrya of instantaneous values.
	 * @param	instantaneousValues
	 * @return
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function fromArray(instantaneousValues : Array<InstantaneousValueI>) : VectorValueI;
	
	/**
	 * Add a scalar value to the vector value.
	 * @param	index
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function push(instantaneousValue: InstantaneousValueI, ?index: Int = 0) : Void;
	
	/**
	 * removes a scalar value from the given index.
	 * @param	index
	 * @return
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function removeFrom(?index: Int = 0) : InstantaneousValueI;
	
	/**
	 * Concatenates given vector value to this vector.
	 * @param	vectorValue
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function concat(vectorValue: VectorValueI) : Void;
	
	/**
	 * slice this vector to fethc a newer vector.
	 * If end is omitted or exceeds this.length(), it defaults to the end of this vector.
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function slice(?startIndex: Int = 0, ?endIndex: Int) : VectorValueI;
	
	/**
	 * Fetch the length of this vector.
	 * @return
	 */
	public function length() : Int;
	
	/**
	 * Fetch the depth of this vector.
	 * @return
	 */
	public function depth() : Int;
	
	/**
	 * returns an iterator for the underlying scalar values. Helpful for looping on vector values.
	 * @return
	 */
	public function iterator() : Iterator<InstantaneousValueI>;
}