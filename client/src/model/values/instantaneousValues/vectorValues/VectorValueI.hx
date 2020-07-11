package model.values.instantaneousValues.vectorValues;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.scalarValues.ScalarValueI;

/**
 * Interface for a Vector Value.
 * Traversed as per the documentation for vectors. Array Indexing : Reverse : [2,1,0]. 2 denotes the end and 0 the beginning.
 * @author AdvaitTrivedi
 */
interface VectorValueI extends InstantaneousValueI
{
	/**
	 * initializes the vector using an array of instantaneous values.
	 * @param	instantaneousValues
	 * @return
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function fromArray(instantaneousValues : Array<InstantaneousValueI>) : VectorValueI;
	
	/**
	 * Add an instantaneous value to the vector value.
	 * Will by default add to the end of the vector value.
	 * WIll throw an invalid index error, if index bigger than length.
	 * @param	index
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function insert(instantaneousValue: InstantaneousValueI, ?index: Int = 0) : Void;
	
	/**
	 * removes a scalar value from the given index.
	 * By default removes the last element of the vector value.
	 * @param	index
	 * @return
	 */
	@:allow(model.values.SignalValueI)
	@:allow(model.values.instantaneousValues.scalarValues.ScalarValueI)
	function removeFrom(?index: Int = 0) : InstantaneousValueI;
	
	/**
	 * Fetch the length of this vector.
	 * @return
	 */
	public function length() : Int;
	
	/**
	 * returns an iterator for the underlying scalar values. Helpful for looping on vector values.
	 * @return
	 */
	public function iterator() : Iterator<InstantaneousValueI>;
}