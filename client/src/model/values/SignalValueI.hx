package model.values;
import haxe.Int64;
import model.attribute.TimeAttributeValue;
import model.values.instantaneousValues.InstantaneousValueI;
import type.TimeUnit;

/**
 * Interface for the Time bound instantaneous values.
 * Traversed as per the documentation for vectors. Array Indexing : Reverse : [2,1,0]. 2 denotes the end and 0 the beginning.
 * @author AdvaitTrivedi
 */
interface SignalValueI 
{
	/**
	 * Checks if the given time instant falls in the permissible range of the signal defined, i.e. either between [startingTime, endingTime].
	 * @param	timeInstant
	 * @param	checkEnding
	 * @return
	 */
	public function isTimeInBounds(timeInstant: Int64 , ?checkEnding: Bool = false) : Bool;
	
	/**
	 * Calculates and gives you the total time the signal expands to.
	 * Can be used as ending time too.
	 * @return
	 */
	public function totalRunningTime() : TimeAttributeValue;
	
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
	 * @param	timeInstant
	 * @return
	 */
	public function getContinuedTimeframe(timeInstant: Int64) : Int64;
}