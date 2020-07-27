package model.values;
import assertions.Assert;
import haxe.Int64;
import model.drawingInterface.SignalDrawingAdapterI;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;
import model.values.instantaneousValues.scalarValues.ScalarValueSingletons;


class SignalFrame {
	var value: InstantaneousValueI;
	var timeFrame: Int64;
	var startTime: Int64;
	
	public function new (startTime: Int64, timeFrame: Int64, value: InstantaneousValueI) {
		this.startTime = startTime;
		this.timeFrame = timeFrame;
		this.value = value;
	}
	
	public function getStartTime() : Int64 {
		return this.startTime;
	}
	
	public function getEndTime() {
		return this.startTime + this.timeFrame;
	}
	
	public function getValue() : InstantaneousValueI {
		return this.value;
	}
	
	public function getTimeFrame() : Int64 {
		return this.timeFrame;
	}
	
	public function setStartTime(startTime: Int64) : Void {
		this.startTime = startTime;
	}
	
	public function setTimeFrame(timeFrame: Int64) : Void {
		this.timeFrame = timeFrame;
	}
	
	public function setValue(value: InstantaneousValueI) : Void {
		this.value = value;
	}
	
	public function isTimeInFrame(timeInstant: Int64) : Bool {
		var greaterThanStartTime = Int64.compare(timeInstant, this.startTime);
		var lesserThanEndTime = Int64.compare(this.getEndTime(), timeInstant);
		return (greaterThanStartTime > 0) && (lesserThanEndTime > 0);
	}
}

/**
 * Time bound Signal value class.
 * 
 * INVARIANT :
 * 1) First time instant is Int64 : 0
 * 2) No SignalFrame in the Signal will ever overstep other SignalFrame's bounds.
 * 3) No adjacent SignalFrame can contain the same value
 * 
 * @author AdvaitTrivedi
 */
class SignalValue implements SignalValueI 
{
	var signalFrameArray: Array<SignalFrame> = new Array<SignalFrame>();
	
	public function new() 
	{
	}
	
	public function invariantCheck() : Void {
		var startingTime: Int64 = this.startingTime();
		if (startingTime != null) {
			var assertion = Int64.eq(startingTime, Int64.make(0, 0));
			Assert.assert(assertion);
		}
	}
	
	/* INTERFACE model.values.SignalValueI */

	/**
	 * Will return the starting time of the signal.
	 * INVARIANT : THis should always return Int64(0)
	 * @return
	 */
	public function startingTime() : Int64 {
		var startingTime: Int64 = Int64.ofInt(0);
		if (this.signalFrameArray.length > 0) {
			startingTime = this.signalFrameArray[0].getStartTime();
		}
		return startingTime;
	}
	
	public function totalRunningTime(): Int64 
	{
		var totalTime: Int64 = Int64.ofInt(0);
		for (signalFrame in this.signalFrameArray) {
			totalTime = totalTime + signalFrame.getTimeFrame();
		}
		return totalTime;
	}
	
	@:arrayAccess
	public function get(timeInstant:Int64):InstantaneousValueI 
	{
		for (signalFrame in this.signalFrameArray) {
			if (signalFrame.isTimeInFrame(timeInstant)) {
				return signalFrame.getValue();
			}
		}
		return ScalarValueSingletons.DONT_CARE;
	}
	
	
	/**
	 * Admitting that this function might not be easy to understand, because a lot of work was put into ensuring that the conditionl logic stays small.
	 * This meant accounting for side-effects (Things happening on the next or previous cycle of the loop that affect the current cycle)
	 * Please bear in mind that the Checks and balances put to ensure parity in functioning.
	 * @param	timeInstant0
	 * @param	timeInstant1
	 * @param	instantaneousValue
	 */
	public function setValueAtTime(timeInstant0:Int64, timeInstant1:Int64, instantaneousValue:InstantaneousValueI):Void 
	{
		var comparison = Int64.compare(Int64.ofInt(0), timeInstant0);
		if (comparison > 0) {
			// do nothing if timeInstant0 is less than 0
			return;
		}
		
		comparison = Int64.compare(timeInstant1, timeInstant0);
		if (comparison <= 0) {
			// end function if timeInstant1 is not strictly greater that timeInstant0
			return;
		}
		
		comparison = Int64.compare(timeInstant0, this.totalRunningTime());
		if (comparison > 0) {
			var undefinedGapFrame  = new SignalFrame(this.totalRunningTime(), timeInstant0 - this.totalRunningTime(), ScalarValueSingletons.DONT_CARE);
			this.signalFrameArray.push(undefinedGapFrame);
		}
		
		var firstAffectedFrame: SignalFrame = null;
		var lastAffectedFrame: SignalFrame = null;
		
		for (signalFrame in this.signalFrameArray) {
			if (firstAffectedFrame == null && signalFrame.isTimeInFrame(timeInstant0)) {
				firstAffectedFrame = signalFrame;
			}
			
			if (lastAffectedFrame == null && signalFrame.isTimeInFrame(timeInstant1)) {
				lastAffectedFrame = signalFrame;
			}
		}
		
		var newSignalArray: Array<SignalFrame> = new Array<SignalFrame>();
		var frameInsert: Bool = true; // set this to false when you do not want a frame to be inserted

		var newSignalFrame  = new SignalFrame(Int64.ofInt(0), timeInstant1 - timeInstant0, instantaneousValue); // set the start time later

		for (signalFrame in this.signalFrameArray) {
			var index = this.signalFrameArray.indexOf(signalFrame);
			if (firstAffectedFrame == signalFrame) {
				// enter firstAffectedFrame and edit it
				var localTimeFrame = timeInstant0 - signalFrame.getStartTime();
				
				if (!Int64.eq(localTimeFrame, Int64.ofInt(0))) {
					// if the difference is not 0, then add a new frame
					var changedSignalFrame = new SignalFrame(signalFrame.getStartTime(), localTimeFrame, signalFrame.getValue());
					newSignalArray.push(changedSignalFrame);
				}
				
				// push current frame onto the new SignalFrame Array
				newSignalFrame.setStartTime(timeInstant0);
				newSignalArray.push(newSignalFrame);
				
				// this will ensure that starting from the first affected frame, no other frame gets pushed onto the new signal frame array
				frameInsert = false;
			}
			
			if (lastAffectedFrame == signalFrame) {
				// edit the lastAffectedFrame 
				trace( signalFrame);
				// this ternary operator condition satisfies, adjacent first and last affected frames
				var localTimeFrame = signalFrame.getEndTime() - timeInstant1;
				
				if (!Int64.eq(localTimeFrame, Int64.ofInt(0))) {
					// if the difference is not 0, then add a new ending frame
					var changedSignalFrame = new SignalFrame(newSignalFrame.getEndTime(), localTimeFrame, signalFrame.getValue());
					newSignalArray.push(changedSignalFrame);
				}
			}
			
			// this will set the flag to true after the lastAffectedFrame has passed
			if (lastAffectedFrame == this.signalFrameArray[index - 1]) {
				frameInsert = true;
			}
				
			
			// now insert all other frames, (except if the currentFrame = firstAffectedFrame = lastAffectedFrame) OR (if no frame has been affected)
			if ((frameInsert && firstAffectedFrame != lastAffectedFrame) || (firstAffectedFrame == null && lastAffectedFrame == null)) {
				newSignalArray.push(signalFrame);
			}
			
		}
		
		if (firstAffectedFrame == null && lastAffectedFrame == null) {
			var newFrame = new SignalFrame(timeInstant0, timeInstant1 - timeInstant0, instantaneousValue);
			newSignalArray.push(newFrame);
		}
		
		this.signalFrameArray = newSignalArray;
		
		// resolve the signal, i.e. maintaining the invariant, where no 2 adjacent frames can contain the same value.
		// will meld the frames with similar values together.
		// can be removed, along with the INVARIANT comment if not needed.
		newSignalArray = new Array<SignalFrame>();
		
		for (signalFrame in this.signalFrameArray) {
			if (newSignalArray.length == 0) {
				newSignalArray.push(signalFrame);
				continue;
			}
			
			// side-effect accounted for
			var lastEntryInNewSignalArray = newSignalArray[newSignalArray.length - 1];
			if (signalFrame.getValue() == lastEntryInNewSignalArray.getValue()) {
				lastEntryInNewSignalArray.setTimeFrame(lastEntryInNewSignalArray.getTimeFrame() + signalFrame.getTimeFrame());
				continue;
			}
			
			newSignalArray.push(signalFrame);
		}
		
		this.signalFrameArray = newSignalArray;

		return;
	}

	public function getContinuedTimeframe(timeInstant: Int64) : Int64 {
		for(signalFrame in this.signalFrameArray) {
			if (signalFrame.isTimeInFrame(timeInstant)) {
				return signalFrame.getTimeFrame() - (timeInstant - signalFrame.getStartTime()); 
			}
		}
		return Int64.ofInt(-1);
	}
	
	public function draw(signalDrawingAdapter: SignalDrawingAdapterI, stratFactory: InstantaneousStratFactoryI, startX: Float, startY: Float) : Void {
		var timeMagnitude: Float = 40; // TODO : Change according to simulation pane zoom. For testing purposes, this is fixed. One would lke to pass it from the parameters.
		var xPosition: Float = startX;
		var yPosition: Float = startY;
		var prevValue: InstantaneousValueI = this.get(this.startingTime());
		
		for (signalFrame in this.signalFrameArray) {
			var value: InstantaneousValueI = signalFrame.getValue();
			for (time in 0...Int64.toInt(signalFrame.getTimeFrame())) {
				signalDrawingAdapter.drawSignalValue(value, stratFactory, xPosition, yPosition, timeMagnitude, (value == prevValue));
				xPosition += timeMagnitude; // test
				prevValue = value;
			}
		}
	}
}