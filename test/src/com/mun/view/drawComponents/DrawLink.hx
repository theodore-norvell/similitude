package com.mun.view.drawComponents;

import com.mun.model.component.Link;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw link
**/
class DrawLink implements DrawComponent{
    var drawingAdapter:DrawingAdapterI;
    var link:Link;

    public function new(link:Link, drawingAdapter:DrawingAdapterI) {
        this.link = link;
        this.drawingAdapter = drawingAdapter;
    }
    public function drawCorrespondingComponent():Void {

        drawingAdapter.drawLine(link.get_leftEndpoint().get_port().get_xPosition(), link.get_leftEndpoint().get_port().get_yPosition(), link.get_rightEndpoint().get_port().get_xPosition(), link.get_rightEndpoint().get_port().get_yPosition());
    }

}
