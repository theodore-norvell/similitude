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
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function and(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
	
	/**
	 * performs a logical OR operation on the passed signalValue parameter with the this value.
	 * @param	signalValue
	 * @return
	 */
	@:allow(model.gates.OR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function or(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
	
	/**
	 * performs a logical NOT operation on the passed signalValue parameter with the this value.
	 * @param	signalValue
	 * @return
	 */
	@:allow(model.gates.NOT)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function not() : InstantaneousValueI;
	
	/**
	 * performs a logical XOR operation on the passed signalValue parameter with the this value.
	 * @param	signalValue
	 * @return
	 */
	@:allow(model.gates.XOR)
	@:allow(model.values.instantaneousValues.InstantaneousValueI)
	function xor(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
}