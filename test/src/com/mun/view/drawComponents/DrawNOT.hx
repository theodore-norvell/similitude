package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw not gate
**/
class DrawNOT implements DrawComponent extends Constant{
    var drawingAdapter:DrawingAdapterI;
    var component:Component;

    public function new(component:Component, drawingAdapter:DrawingAdapterI) {
        super();
        this.component = component;
        this.drawingAdapter = drawingAdapter;
    }

    public function drawCorrespondingComponent(strokeColor:String):Void {
        if(strokeColor == null || strokeColor == ""){
            strokeColor = "black";
        }
        drawingAdapter.setStrokeColor(strokeColor);

        drawingAdapter.drawNotShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        //draw inport
        var inportArray:Array<Port> = component.get_inportArray();
        for (i in 0...inportArray.length) {
            var port:Port = inportArray[i];
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);
        }
        //draw outport
        var outportArray:Array<Port> = component.get_outportArray();
        for (i in 0...outportArray.length) {
            var port:Port = outportArray[i];
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);
        }

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();

    }

}
