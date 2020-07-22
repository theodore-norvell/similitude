package model.drawingInterface;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;

/**
 * @author AdvaitTrivedi
 */
interface SignalDrawingAdapterI 
{
	public function resetDrawingParam() : Void;

    public function setStrokeColor(color:String):Void;
	
    public function setFillColor(color:String):Void;

    public function setTextColor(color:String):Void;

    public function setTextFont(font:String):Void;

    public function setLineWidth(width:Float):Void;

    public function getTransform():Transform;

    public function transform(transform:Transform):SignalDrawingAdapterI;
	
	public function drawSignalValue(value: InstantaneousValueI, drawingStrategy: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation: Bool = false):Void;
}