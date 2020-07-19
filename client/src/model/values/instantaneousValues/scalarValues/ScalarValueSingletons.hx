package model.values.instantaneousValues.scalarValues;

/**
 * No new memory will ever be allocated for These Scalar values.
 * Use the singletons(this) class to manipulate/use these scalar values in various places as you wish.
 * Errors will be generated and thrown off, they are not to be included in singleton classes.
 * 
 * Error values are scraped off the moment they are used and newly created for every new error.
 * 
 * @author AdvaitTrivedi
 */
class ScalarValueSingletons
{
	public static var HIGH: HighValue = new HighValue();
	public static var LOW: LowValue = new LowValue();
	public static var TRI_STATE: TriStateValue = new TriStateValue();
	public static var DONT_CARE: DontCareValue = new DontCareValue();
}