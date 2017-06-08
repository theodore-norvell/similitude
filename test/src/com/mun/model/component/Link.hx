package com.mun.model.component;

/**
 * Link consist of two endpoints
 * @author wanhui
 *
 */
import com.mun.view.drawComponents.DrawComponent;
import com.mun.view.drawComponents.DrawLink;
import com.mun.model.drawingInterface.DrawingAdapterI;
class Link {
    var leftEndpoint:Endpoint;
    var rightEndpoint:Endpoint;

    public function new(leftEndpoint:Endpoint, rightEndpoint:Endpoint) {
        this.leftEndpoint = leftEndpoint;
        this.rightEndpoint = rightEndpoint;
    }

    public function get_leftEndpoint():Endpoint {
        return leftEndpoint;
    }

    public function set_leftEndpoint(value:Endpoint) {
        return this.leftEndpoint = value;
    }

    public function get_rightEndpoint():Endpoint {
        return rightEndpoint;
    }

    public function set_rightEndpoint(value:Endpoint) {
        return this.rightEndpoint = value;
    }

    public function drawLink(drawingAdapter:DrawingAdapterI, highLight:Bool){
        var drawComponent:DrawComponent = new DrawLink(this, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
    }
}
