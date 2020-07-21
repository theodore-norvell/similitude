package model.values.instantaneousValues.scalarValues;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.vectorValues.VectorValueI;
import model.values.instantaneousValues.vectorValues.VectorValue;

/**
 * ...
 * @author AdvaitTrivedi
 */
class LowValue extends AbstractScalarValue
{

	public function new() 
	{
		
	}
	
	override public function toString():String 
	{
		return "L";
	}
	
	@:allow(model.gates.AND)
	//@:allow(model.values.instantaneousValues.InstantaneousValueI)
	@:allow(model.values.instantaneousValues.vectorValues.VectorValue)
	@:allow(model.values.instantaneousValues.scalarValues.TriStateValue)
	@:allow(model.values.instantaneousValues.scalarValues.LowValue)
	@:allow(model.values.instantaneousValues.scalarValues.HighValue)
	@:allow(model.values.instantaneousValues.scalarValues.errorValues.StringErrorValue)
	override function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		if (Std.is(instantaneousValue, VectorValueI)) {
			var instantaneousValueArray = new Array<InstantaneousValueI>();
			var vectorValue = Std.downcast(instantaneousValue, VectorValue);
			for (value in vectorValue) {
				instantaneousValueArray.push(this);
			}
			return new VectorValue(instantaneousValueArray);
		} else {
			return this;
		}
	}
	
	@:allow(model.gates.OR)
	//@:allow(model.values.instantaneousValues.InstantaneousValueI)
	@:allow(model.values.instantaneousValues.vectorValues.VectorValue)
	@:allow(model.values.instantaneousValues.scalarValues.TriStateValue)
	@:allow(model.values.instantaneousValues.scalarValues.LowValue)
	@:allow(model.values.instantaneousValues.scalarValues.HighValue)
	@:allow(model.values.instantaneousValues.scalarValues.errorValues.StringErrorValue)
	override function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return instantaneousValue;
	}
	
	@:allow(model.gates.NOT)
	//@:allow(model.values.instantaneousValues.InstantaneousValueI)
	@:allow(model.values.instantaneousValues.vectorValues.VectorValue)
	@:allow(model.values.instantaneousValues.scalarValues.TriStateValue)
	@:allow(model.values.instantaneousValues.scalarValues.LowValue)
	@:allow(model.values.instantaneousValues.scalarValues.HighValue)
	@:allow(model.values.instantaneousValues.scalarValues.errorValues.StringErrorValue)
	override function not():InstantaneousValueI 
	{
		return Std.downcast(ScalarValueSingletons.HIGH, HighValue);
	}
	
	@:allow(model.gates.XOR)
	//@:allow(model.values.instantaneousValues.InstantaneousValueI)
	@:allow(model.values.instantaneousValues.vectorValues.VectorValue)
	@:allow(model.values.instantaneousValues.scalarValues.TriStateValue)
	@:allow(model.values.instantaneousValues.scalarValues.LowValue)
	@:allow(model.values.instantaneousValues.scalarValues.HighValue)
	@:allow(model.values.instantaneousValues.scalarValues.errorValues.StringErrorValue)
	override function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI 
	{
		return this.or(instantaneousValue);
	}
	
	override public function draw(context: CanvasRenderingContext2D, drawingStrategy: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void {
		drawingStrategy.getLowStrat().draw(context, startX, startY, timeMagnitude, continuation);
	}
}