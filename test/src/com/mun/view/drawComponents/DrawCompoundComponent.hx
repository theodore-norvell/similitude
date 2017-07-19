package com.mun.view.drawComponents;
import com.mun.model.component.Port;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.global.Constant.*;

class DrawCompoundComponent implements DrawComponent{
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

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setTextColor("black");
        drawingAdapter.drawText(component.get_name(), component.get_xPosition() - 8, component.get_yPosition(), component.get_width() - 2);

        //draw inport
        for (i in component.get_inportIterator()) {
            var port:Port = i;
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);

            //draw text
            drawingAdapter.setTextColor("black");
            switch (component.get_orientation()){
                case ORIENTATION.EAST : {
                    drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 4);
                };
                case ORIENTATION.WEST : {
                    drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 4);
                };
                case ORIENTATION.SOUTH : {
                    drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 4);
                };
                case ORIENTATION.NORTH : {
                    drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 4);
                };
                default : {
                    //nothing
                }
            }

        }

        //draw outport
        for (i in component.get_outportIterator()) {
            var port:Port = i;
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);
        }

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }
}
