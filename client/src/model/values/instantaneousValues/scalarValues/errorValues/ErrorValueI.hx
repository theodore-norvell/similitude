package model.values.instantaneousValues.scalarValues.errorValues;
import model.values.instantaneousValues.scalarValues.ScalarValueI;

/**
 * @author AdvaitTrivedi
 */
interface ErrorValueI extends ScalarValueI
{
	public function getErrorMessage() : String;
}