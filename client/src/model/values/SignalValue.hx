package model.values;
import assertions.Assert;
import haxe.Int64;
import haxe.ds.Map;
import js.html.CanvasRenderingContext2D;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import type.TimeUnit;
import model.attribute.TimeAttributeValue;

/**
 * Time bound Signal value Map class.
 * 
 * INVARIANT :
 * First time instant is Int64 : 0
 * @author AdvaitTrivedi
 */
class SignalValue implements SignalValueI 
{
	var valueMap: Map<Int64, InstantaneousValueI> = new Map<Int64, InstantaneousValueI>();
	var timeUnit: TimeUnit;
	
	public function new(timeUnit: TimeUnit) 
	{
		this.timeUnit = timeUnit;
	}
	
	public function invariantCheck() : Void {
		var beginning: Int64 = this.startingTime();
		if (beginning != null) {
			var assertion = Int64.eq(beginning, Int64.make(0, 0));
			Assert.assert(assertion);
		}
	}
	
	/* INTERFACE model.values.SignalValueI */

	public function startingTime() : Int64 {
		var beginning: Int64 = null;
		var i = 0;
		for (time in this.valueMap.keys()) {
			if (i == 0) {
				beginning = time;
				break;
			}
		}
		
		return beginning;
	}
	
	public function totalRunningTime(): Int64 
	{
		var endingTime: Int64 = null;
		var timeKeyIterator = this.valueMap.keys();
		while (timeKeyIterator.hasNext()) {
			endingTime = timeKeyIterator.next();
		}
		
		return endingTime;
	}
	
	public function getUnit():TimeUnit 
	{
		return this.timeUnit;
	}
	
	public function setUnit(timeUnit:TimeUnit):Void 
	{
		this.timeUnit = timeUnit;
	}
	
	@:arrayAccess
	public function get(timeInstant:Int64):InstantaneousValueI 
	{
		if (this.valueMap.exists(timeInstant)) {
			return this.valueMap[timeInstant];
		}
		throw("this time instant does not exist");
	}
	
	public function setValueAtTime(timeInstant0:Int64, timeInstant1:Int64, instantaneousValue:InstantaneousValueI):Void 
	{
		var comparison = Int64.compare(timeInstant1, timeInstant0);
		if (this.valueMap.exists(timeInstant0)) {
			for (i in Int64.toInt(timeInstant0)...Int64.toInt(timeInstant1)) {
				this.valueMap.set(i, instantaneousValue);
			}
		}
	}
	
	public function pushValue(instantaneousValue: InstantaneousValueI) : Void {
		var timeInstant = Int64.ofInt(0);
		if (this.startingTime() != null) {
			var timeInstant =this.totalRunningTime() + Int64.ofInt(1);
		}
		
		this.valueMap.set(timeInstant, instantaneousValue);
	}
	
	public function getContinuedTimeframe(timeInstant: Int64) : Int64 {
		var givenValue = this.valueMap[timeInstant];
		var timeFrame : Int64 = Int64.ofInt(0);
		for (time => value in this.valueMap) {
			if (time >= timeInstant && value == givenValue) {
				timeFrame = timeFrame + Int64.ofInt(1);
			}
			
			// side effect check. Will break loop once the value stops being the same
			if (time >= timeInstant && value != givenValue) {
				break;
			}
		}
		
		return timeFrame;
	}
	
	public function setDrawingStrategy(stratFactory: InstantaneousStratFactoryI) : Void {
		for (time => value in this.valueMap) {
			value.setDrawingStrategy(stratFactory);
		}
	}
	
	public function draw(context: CanvasRenderingContext2D, startX: Float, startY: Float) : Void {
		
		var timeMagnitude : Float = switch( this.timeUnit ) {
            case TimeUnit.FEMPTO_SECOND: 70;
            case TimeUnit.PICO_SECOND: 60;
            case TimeUnit.NANO_SECOND: 50;
            case TimeUnit.MICRO_SECOND: 40;
            case TimeUnit.MILI_SECOND: 30;
            case TimeUnit.SECOND: 20;
        } ;
		var xPosition = startX;
		var yPosition = startY;
		context.lineWidth = 1.0;
		var prevValue : InstantaneousValueI = this.valueMap[this.startingTime()];
		for (time => value in this.valueMap) {
			value.draw(context, xPosition, yPosition, timeMagnitude, (value == prevValue)); // test
			xPosition += timeMagnitude; // test
			prevValue = value;
		}
	}
}