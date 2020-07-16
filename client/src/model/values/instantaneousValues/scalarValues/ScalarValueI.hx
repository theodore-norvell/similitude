package model.values.instantaneousValues.scalarValues;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.vectorValues.VectorValueI;

/**
 * @author AdvaitTrivedi
 */
interface ScalarValueI extends InstantaneousValueI
{
	/**
	 * returns the scalar in the form of a 1 length vector value
	 * @return
	 */
	public function toVectorValue() : VectorValueI;
	
	@:op(A == B)
	public function equal(scalarValue: ScalarValueI) : Bool 
}