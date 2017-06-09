package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw OR gate
* @author wanhui
**/
class DrawOR implements DrawComponent extends Constant{
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

        drawingAdapter.drawOrShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        //draw inport
        for (i in component.get_inportIterator()) {
            var port:Port = i;
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);
        }
        //draw outport
        for (i in component.get_outportIterator()) {
            var port:Port = i;
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);
        }

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }
}
