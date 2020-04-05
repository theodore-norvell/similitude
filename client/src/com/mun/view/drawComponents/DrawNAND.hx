package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.global.Constant.*;
/**
* draw NAND gate
* *
* @author wanhui
**/
class DrawNAND implements DrawComponent{
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

        drawingAdapter.drawNAndShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
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
