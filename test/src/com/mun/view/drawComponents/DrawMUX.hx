package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
/**
* draw mux gate
* @author wanhui
**/
class DrawMUX implements DrawComponent {
    var drawingAdapter:DrawingAdapterI;
    var component:Component;

    public function new(component:Component, drawingAdapter:DrawingAdapterI) {
        this.component = component;
        this.drawingAdapter = drawingAdapter;
    }

    public function drawCorrespondingComponent():Void {
        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setTextColor("black");
        drawingAdapter.drawText("MUX", component.get_xPosition() - 8, component.get_yPosition(), component.get_width() - 2);

        //draw inport
        var inportArray:Array<Port> = component.get_inportArray();
        for (i in 0...inportArray.length) {
            var port:Port = inportArray[i];
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), 2);

            //draw text
            drawingAdapter.setTextColor("black");
            switch (component.get_orientation()){
                case Orientation.EAST : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() - 2, port.get_yPosition() + 10, component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() + 3, port.get_yPosition() + 2, component.get_width() - 4);
                    }
                };
                case Orientation.WEST : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() - 2, port.get_yPosition() + 10, component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 8, port.get_yPosition(), component.get_width() - 4);
                    }
                };
                case Orientation.SOUTH : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() + 3, port.get_yPosition(), component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition(), port.get_yPosition() + 10, component.get_width() - 4);
                    }
                };
                case Orientation.NORTH : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() - 7, port.get_yPosition() + 2, component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 4);
                    }
                };
                default : {
                    //nothing
                }
            }

        }

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
