package com.mun.view.drawComponents;

import com.mun.model.component.Link;
import com.mun.model.drawingInterface.DrawingAdapterI;
/**
* draw link
**/
class DrawLink implements DrawComponent extends Constant{
    var drawingAdapter:DrawingAdapterI;
    var link:Link;

    public function new(link:Link, drawingAdapter:DrawingAdapterI) {
        super();
        this.link = link;
        this.drawingAdapter = drawingAdapter;
    }
    public function drawCorrespondingComponent(strokeColor:String):Void {
        if(strokeColor == null || strokeColor == ""){
            strokeColor = "black";
        }
        drawingAdapter.setStrokeColor(strokeColor);
        drawingAdapter.drawLine(link.get_leftEndpoint().get_xPosition(), link.get_leftEndpoint().get_yPosition(), link.get_rightEndpoint().get_xPosition(), link.get_rightEndpoint().get_yPosition());
    }

}
