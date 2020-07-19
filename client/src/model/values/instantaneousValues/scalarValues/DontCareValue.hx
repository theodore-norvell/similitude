package model.values.instantaneousValues.scalarValues;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.vectorValues.VectorValue;
import model.values.instantaneousValues.vectorValues.VectorValueI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DontCareValue extends AbstractScalarValue 
{

	public function new() 
	{
		
	}
	
	override public function toString():String {
		return "X"; 
	}
	
	override public function setDrawingStrategy(stratFactory: InstantaneousStratFactoryI) : Void {
		this.drawingStrategy = stratFactory.getDontCareStrat();
	}
	
	function logicOperation(instantaneousValue:InstantaneousValueI) : InstantaneousValueI {
		if (Std.is(instantaneousValue, VectorValueI)) {
			var instantaneousValueArray = new Array<InstantaneousValueI>();
			var vectorValue = Std.downcast(instantaneousValue, VectorValue);
			for (value in vectorValue) {
				instantaneousValueArray.push(this);
			}
			return new VectorValue(instantaneousValueArray);
		}
		return this;
	}

	override public function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}

	override public function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}

	override public function not():InstantaneousValueI 
	{
		return this;
	}
	
	override public function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.logicOperation(instantaneousValue);
	}
}