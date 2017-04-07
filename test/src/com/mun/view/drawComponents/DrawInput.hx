package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw input gate
* @author wanhui
**/
class DrawInput implements DrawComponent {
    var drawingAdapter:DrawingAdapterI;
    var component:Component;

    public function new(component:Component, drawingAdapter:DrawingAdapterI) {
        this.component = component;
        this.drawingAdapter = drawingAdapter;
    }

    public function drawCorrespondingComponent():Void {
        //set the radius equal to 7
        drawingAdapter.setFillColor("red");
        drawingAdapter.drawCricle(component.get_xPosition(), component.get_yPosition(), 7);
        drawingAdapter.setTextColor("black");
        //drawingAdapter.drawText("Input", component.get_yPosition(), component.get_yPosition(), component.get_width() - 2);
        //input gate shouldn't have inport
        //draw outport
        var outportArray:Array<Port> = component.get_outportArray();
        for (i in 0...outportArray.length) {
            var port:Port = outportArray[i];
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), 2);
        }

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

}
