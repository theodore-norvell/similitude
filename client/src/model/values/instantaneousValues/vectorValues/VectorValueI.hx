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