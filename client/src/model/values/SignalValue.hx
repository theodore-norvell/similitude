package model.values;
import assertions.Assert;
import haxe.Int64;
import haxe.ds.Map;
import model.values.instantaneousValues.InstantaneousValueI;
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
			Assert.assert(Int64.eq(beginning, Int64.make(0,0)));
		}
	}
	
	/* INTERFACE model.values.SignalValueI */
	
	public function isTimeInBounds(timeInstant: Int64 , ?checkEnding: Bool = false) : Bool {
		var beginning: Int64 = this.startingTime();
		if (beginning != null) {
			var comparison = Int64.compare(timeInstant, beginning);
			if (comparison > 0 || comparison == 0)) {
				if (checkEnding) {
					var endingComparison = Int64.compare(timeInstant, this.totalRunningTime());
					if (endingComparison > 0 || endingComparison == 0) {
						return true;
					} else {
						return false;
					}
				} else {
					return true;
				}
			} else {
				return false;
			}
		} else {
			return true;
		}
	}
	
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
		return this.valueMap[timeInstant];
	}
	
	public function setValueAtTime(timeInstant0:Int64, timeInstant1:Int64, instantaneousValue:InstantaneousValueI):Void 
	{
		var comparison = Int64.compare(timeInstant1, timeInstant0);
		if (this.isTimeInBounds(timeInstant0) && (comparison > 0 || comparison == 0)) {
			for (i in timeInstant0...timeInstant1) {
				this.valueMap.set(i, instantaneousValue);
			}
		}
	}
	
	public function pushValue(instantaneousValue: InstantaneousValueI) : Void {
		var timeInstant = Int64.ofInt(0);
		if (this.startingTime() != null) {
			var timeInstant = Int64.make(Int64.add(this.totalRunningTime(), Int64.ofInt(1)));
		}
		
		this.valueMap.set(timeInstant, instantaneousValue);
	}
}