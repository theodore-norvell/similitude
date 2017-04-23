package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw output gate
* @author wanhui
**/
class DrawOutput implements DrawComponent{
    var drawingAdapter:DrawingAdapterI;
    var component:Component;

    public function new(component:Component, drawingAdapter:DrawingAdapterI) {
        this.component = component;
        this.drawingAdapter = drawingAdapter;
    }

    public function drawCorrespondingComponent(strokeColor:String):Void {
        if(strokeColor == null || strokeColor == ""){
            strokeColor = "black";
        }
        drawingAdapter.setStrokeColor(strokeColor);

        //set the radius equal to 7
        drawingAdapter.setFillColor("red");
        drawingAdapter.drawCricle(component.get_xPosition(), component.get_yPosition(), 7);
        drawingAdapter.setTextColor("black");
        //drawingAdapter.drawText("Output", component.get_yPosition, component.get_yPosition(), component.get_width() - 2);
        //output gate shouldn't have output port
        //draw inport
        var inportArray:Array<Port> = component.get_inportArray();
        for (i in 0...inportArray.length) {
            var port:Port = inportArray[i];
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), 2);
        }

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }
}
