package model.values.instantaneousValues;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;

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
	 * This function essentially let's every value draw itself.
	 * The reference , i.e. startX and startY always are at the bottom left starting point of the value. The value then uses this start point to make it's way.
	 * @param	context : Of the relevant canvas to draw on.
	 * @param	startX : Start point X of the individual value. Handled in the SignalValue class.
	 * @param	startY : Start point Y of the individual value. Handled in the SignalValue class.
	 * @param	timeMagnitude : Refers to the magnification in time units. This will enable zooming into the time in the signal.
	 * @param	continuation : Is this value in continuation to the last one or is it different from the last one.
	 */
	public function draw(context: CanvasRenderingContext2D, drawingStrategy: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = false) : Void;
	
	/**
	 * performs Logical AND operation on the passed signalValue parameter with the this value. 
	 * @param	signalValue
	 * @return
	 */
	public function and(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
	
	/**
	 * performs a logical OR operation on the passed signalValue parameter with the this value.
	 * @param	signalValue
	 * @return
	 */
	public function or(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
	
	/**
	 * performs a logical NOT operation on the passed signalValue parameter with the this value.
	 * @param	signalValue
	 * @return
	 */
	public function not() : InstantaneousValueI;
	
	/**
	 * performs a logical XOR operation on the passed signalValue parameter with the this value.
	 * @param	signalValue
	 * @return
	 */
	public function xor(instantaneousValue: InstantaneousValueI) : InstantaneousValueI;
}