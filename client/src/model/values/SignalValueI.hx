package model.values;
import haxe.Int64;
import js.html.CanvasRenderingContext2D;
import model.attribute.TimeAttributeValue;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import type.TimeUnit;

/**
 * Interface for the Time bound instantaneous values.
 * Traversed as per the documentation for vectors. Array Indexing : Reverse : [2,1,0]. 2 denotes the end and 0 the beginning.
 * @author AdvaitTrivedi
 */
interface SignalValueI 
{	
	/**
	 * Calculates and gives you the total time the signal expands to.
	 * Can be used as ending time too.
	 * @return
	 */
	public function totalRunningTime() : Int64;
	
	/**
	 * Get the unit of the time range.
	 * @return
	 */
	public function getUnit() : TimeUnit;
	
	/**
	 * Set the unit of the time range
	 * @param	timeUnit
	 */
	public function setUnit(timeUnit: TimeUnit) : Void;
	
	/**
	 * Gets the instantaneous value at a particular time.
	 * @param	timeInstant
	 * @return
	 */
	@:arrayAccess
	public function get(timeInstant: Int64) : InstantaneousValueI;
	
	/**
	 * Sets the instantaneous values at a specific time range.
	 * @param	timeInstant0
	 * @param	timeInstant1
	 * @param	instantaneousValue
	 */
	public function setValueAtTime(timeInstant0: Int64, timeInstant1: Int64, instantaneousValue: InstantaneousValueI) : Void;
	
	/**
	 * This function returns the time frame (or gap) for which the value of the signal remains the same, starting from "timeInstant".
	 * 
	 * This might or might not be needed. Remove if not needed.
	 * 
	 * @param	timeInstant
	 * @return
	 */
	public function getContinuedTimeframe(timeInstant: Int64) : Int64;
	
	/**
	 * Draw the signal on a given canvas. the starting points refer to the bottom-left corner of the signal starting.
	 * @param	context : CanvasContext (2D) refering to the relevant canvas.
	 * @param	startX : Handled in the consumer.
	 * @param	startY : Handled in the consumer.
	 */
	public function draw(context: CanvasRenderingContext2D, stratFactory: InstantaneousStratFactoryI, startX: Float, startY: Float) : Void;
}