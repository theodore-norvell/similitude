package model.tabModel;

/**
 * This object is supposed to be passed in TabModel so that it can be linked to a respective canvas.
 * Use the fields to store and manipulate the panning in the canvas.
 * Not sure if this should go through the Command manager or not, but, for now, it feels it should not.
 * @author AdvaitTrivedi
 */
class CanvasPan 
{
	public var totalXPan: Float = 0;
	public var totalYPan: Float = 0;

	public function new() 
	{

	}
	
	public function moveXPositive(diff: Float) : Float {
		this.totalXPan = this.totalXPan + diff;
		return this.totalXPan;
	}
	
	public function moveYPositive(diff: Float) : Float {
		this.totalYPan = this.totalYPan + diff;
		return this.totalYPan;
	}
	
	public function moveXNegative(diff: Float) : Float {
		this.totalXPan = this.totalXPan - diff;
		return this.totalXPan;
	}
	
	public function moveYNegative(diff: Float) : Float {
		this.totalYPan = this.totalYPan - diff;
		return this.totalYPan;
	}
	
	/**
	 * Returns the total pan in X direction for the canvas and sets the pan to zero.
	 * @return
	 */
	public function centreX () : Float {
		var difference = this.totalXPan;
		this.totalXPan = 0;
		return difference;
	}
	
	public function centreY () : Float {
		var difference = this.totalYPan;
		this.totalYPan = 0;
		return difference;
	}
}