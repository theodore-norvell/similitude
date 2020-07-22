package model.values.instantaneousValues.scalarValues;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.displayStrategies.InstantaneousDrawStrategyI;
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
	
	override public function getDrawingStrategy(stratFactory: InstantaneousStratFactoryI) : InstantaneousDrawStrategyI {
		return stratFactory.getDontCareStrat();
	}
	
	//override public function draw(context: CanvasRenderingContext2D, drawingStrategy: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void {
		//drawingStrategy.getDontCareStrat().draw(context, startX, startY, timeMagnitude, continuation);
	//}
}