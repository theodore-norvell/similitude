package model.values.instantaneousValues.scalarValues;

/**
 * No new memory will ever be allocated for values.
 * Use the singleton class to manipulate them
 * @author AdvaitTrivedi
 */
@:enum
abstract ScalarValueSingletons(ScalarValueI) 
{
	var HIGH = new HighValue();
	var LOW = new LowValue();
}