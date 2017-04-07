package com.mun.view.drawComponents;

import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw link
**/
class DrawLink implements DrawComponent{
    var drawingAdapter:DrawingAdapterI;
    var port1:Port;
    var port2:Port;

    public function new(port1:Port, port2:Port, drawingAdapter:DrawingAdapterI) {
        this.port1 = port1;
        this.port2 = port2;
        this.drawingAdapter = drawingAdapter;
    }
    public function drawCorrespondingComponent():Void {
        drawingAdapter.drawLine(port1.get_xPosition(), port1.get_yPosition(), port2.get_xPosition(), port2.get_yPosition());
    }

}
