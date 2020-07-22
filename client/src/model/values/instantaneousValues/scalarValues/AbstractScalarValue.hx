package model.values.instantaneousValues.scalarValues;
import assertions.Assert;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousDrawStrategyI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.vectorValues.VectorValue;
import model.values.instantaneousValues.vectorValues.VectorValueI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractScalarValue implements ScalarValueI 
{	
	/* INTERFACE model.values.instantaneousValues.scalarValues.ScalarValueI */
	
	public function toVectorValue():VectorValueI 
	{
		return new VectorValue([this]);
	}
	
	public function toString():String {
		Assert.assert(false);
		return ""; 
	}
	
	public function getDrawingStrategy(stratFactory: InstantaneousStratFactoryI) : InstantaneousDrawStrategyI {
		Assert.assert(false);
		return null;
	}	
	
	public function draw(context: CanvasRenderingContext2D, drawingStrategy: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation:Bool = true) : Void {
		Assert.assert(false);
	}
	
	@:op(A == B)
	public function equal(scalarValue:ScalarValueI) : Bool {
		return this.toString() == scalarValue.toString();
	}

	public function and(instantaneousValue:InstantaneousValueI):InstantaneousValueI {
		Assert.assert(false);
		return this; 
		
	}

	public function or(instantaneousValue:InstantaneousValueI):InstantaneousValueI {
		Assert.assert(false);
		return this; 
		
	}

	public function not():InstantaneousValueI {
		Assert.assert(false);
		return this; 
	}
	
	public function xor(instantaneousValue:InstantaneousValueI):InstantaneousValueI {
		Assert.assert(false);
		return this; 
	}
	
}