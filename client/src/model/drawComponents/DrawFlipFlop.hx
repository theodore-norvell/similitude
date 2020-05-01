package model.drawComponents;

import model.component.Component;
import model.component.Port;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
import global.Constant.*;
/**
* draw flip flop
* @author wanhui
**/
class DrawFlipFlop extends DrawComponent{

    public function new(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool ) {
        super( component, drawingAdapter, highlight ) ;
    }

    public function drawCorrespondingComponent() : Void {
        this.setColor() ;

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.drawText("FF", component.get_xPosition() - 4, component.get_yPosition(), component.get_width());
        // Draw the ports
        this.drawPorts() ;
        // TODO: Abstract out the text drawing.
        drawingAdapter.setTextColor("black") ;
        for (port in component.get_ports()) {
            switch(component.get_orientation()){
                case Orientation.NORTH : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() - 6, port.get_yPosition() - 5, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() - 2, port.get_yPosition() + 10, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() - 6, port.get_yPosition() + 10, component.get_width() - 2);
                    }
                };
                case Orientation.SOUTH : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() - 3, port.get_yPosition() + 10, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() - 3, port.get_yPosition() + 10, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() - 3, port.get_yPosition() - 7, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() - 3, port.get_yPosition() - 7, component.get_width() - 2);
                    }
                };
                case Orientation.WEST : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() - 10, port.get_yPosition() + 2, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() - 20, port.get_yPosition() + 2, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() + 3, port.get_yPosition() + 2, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() + 3, port.get_yPosition() + 2, component.get_width() - 2);
                    }
                };
                case Orientation.EAST : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() + 3, port.get_yPosition() + 3, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() + 3, port.get_yPosition() + 3, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() - 10, port.get_yPosition() + 3, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() - 14, port.get_yPosition() + 3, component.get_width() - 2);
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
