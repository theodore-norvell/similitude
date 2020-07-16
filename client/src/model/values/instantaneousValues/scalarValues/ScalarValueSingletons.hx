package model.values.instantaneousValues.scalarValues;

/**
 * No new memory will ever be allocated for values.
 * Use the singleton class to manipulate them.
 * Errors will be generated and thrown off, they are not to be included in singleton classes.
 * @author AdvaitTrivedi
 */
@:enum
abstract ScalarValueSingletons(ScalarValueI) 
{
	var HIGH: HighValue = new HighValue();
	var LOW: LowValue = new LowValue();
	var Z: TriStateValue = new TriStateValue();
	var X: DontCareValue = new DontCareValue();
}