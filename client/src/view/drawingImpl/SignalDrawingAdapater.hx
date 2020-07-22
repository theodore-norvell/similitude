package view.drawingImpl;
import js.html.CanvasRenderingContext2D;
import model.drawingInterface.SignalDrawingAdapterI;
import model.drawingInterface.Transform;
import model.values.instantaneousValues.InstantaneousValueI;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactoryI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class SignalDrawingAdapater implements SignalDrawingAdapterI
{	
	var cxt:CanvasRenderingContext2D;
    var strokeColor:String = "black";//default line color is black
    var fillColor:String = "gray";//default fill color is gray
    var textColor:String = "black";//default text color is black
    var lineWidth:Float = 1.0;//because the defalut line width is 1.0
    var font:String = "8px serif";//initial is 8
    var trans:Transform;

    public function new(transform:Transform, context:CanvasRenderingContext2D) {
        this.trans = transform;
        this.cxt = context;
    }

    public function resetDrawingParam() {
        strokeColor = "black";//default line color is black
        fillColor = "gray";//default fill color is gray
        textColor = "black";//default text color is black
        lineWidth = 1.0;//because the defalut line width is 1.0
        font = "8px serif";//initial is 8
    }

    public function setStrokeColor(color:String):Void {
        strokeColor = color;
    }

    public function setFillColor(color:String):Void {
        fillColor = color;
    }

    public function setTextColor(color:String):Void {
        textColor = color;
    }

    public function setTextFont(font:String):Void {
        this.font = font;
    }

    public function setLineWidth(width:Float):Void {
        cxt.lineWidth = width;
    }

    public function getTransform():Transform{
        return this.trans;
    }

    public function transform(transform:Transform):SignalDrawingAdapterI{
        var drawingAdapter:SignalDrawingAdapater = new SignalDrawingAdapater(transform.compose(trans), cxt);
        return drawingAdapter;
    }
	
	public function drawSignalValue(value: InstantaneousValueI, stratFactory: InstantaneousStratFactoryI, startX: Float, startY: Float, timeMagnitude: Float, ?continuation: Bool = false) {
		value.getDrawingStrategy(stratFactory).draw(cxt, startX, startY, timeMagnitude, continuation);
	}
}