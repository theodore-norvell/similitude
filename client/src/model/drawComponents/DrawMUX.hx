package model.drawComponents;

import model.component.Component;
import model.component.Port;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
import global.Constant.*;
/**
* draw mux gate
* @author wanhui
**/
class DrawMUX extends DrawComponent {

    public function new(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool ) {
        super( component, drawingAdapter, highlight ) ;
    }

    public function drawCorrespondingComponent() : Void {
        this.setColor() ;

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setTextColor("black");
        drawingAdapter.drawText("MUX", component.get_xPosition(), component.get_yPosition(), component.get_width());

        // Draw the ports.
        this.drawPorts() ;


        // TODO Put this all in one place.
        drawingAdapter.setTextColor("black");
        for (port in component.get_ports()) {
            //draw text
            switch (component.get_orientation()){
                case ORIENTATION.EAST : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() - 2, port.get_yPosition() + 10, component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() + 3, port.get_yPosition() + 2, component.get_width() - 4);
                    }
                };
                case ORIENTATION.WEST : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() - 2, port.get_yPosition() + 10, component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition() - 8, port.get_yPosition(), component.get_width() - 4);
                    }
                };
                case ORIENTATION.SOUTH : {
                    if (port.get_portDescription() == IOTYPE.S) {
                        drawingAdapter.drawText("S", port.get_xPosition() + 3, port.get_yPosition(), component.get_width() - 4);
                    } else {
                        drawingAdapter.drawText(port.get_sequence() + "", port.get_xPosition(), port.get_yPosition() + 10, component.get_width() - 4);
                    }
                };
                case ORIENTATION.NORTH : {
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

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

}
