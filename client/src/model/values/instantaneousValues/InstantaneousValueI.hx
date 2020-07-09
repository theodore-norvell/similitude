package model.values.instantaneousValues;

/**
 * @author AdvaitTrivedi
 */
interface InstantaneousValueI 
{
	/**
	 * Returns a string representation of the signal value.
	 * @return
	 */
	public function toString() : String;
	
	/**
	 * performs Logical AND operation on the passed signalValue parameter with the this value. 
	 * @param	signalValue
	 * @return
	 */
	@:allow(model.gates.AND)
	function and(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
	
	/**
	 * performs a logical OR operation on the passed signalValue parameter with the this value
	 * @param	signalValue
	 * @return
	 */
	@:allow(model.gates.OR)
	function or(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
	
	/**
	 * performs a logical NOT operation on the passed signalValue parameter with the this value
	 * @param	signalValue
	 * @return
	 */
	@:allow(model.gates.NOT)
	function not(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
}