package com.mun.view.drawComponents;
import com.mun.model.component.Component;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
/**
* draw flip flop
* @author wanhui
**/
class DrawFlipFlop implements DrawComponent {
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
        drawingAdapter.drawText("FF", component.get_xPosition() - 4, component.get_yPosition(), component.get_width());
        //draw inport
        var inportArray:Array<Port> = component.get_inportArray();
        for (i in 0...inportArray.length) {
            var port:Port = inportArray[i];
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), 2);
            switch(component.get_orientation()){
                case Orientation.NORTH : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() - 2, port.get_yPosition() - 5, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() - 6, port.get_yPosition() - 5, component.get_width() - 2);
                    }
                };
                case Orientation.SOUTH : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() - 3, port.get_yPosition() + 10, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() - 3, port.get_yPosition() + 10, component.get_width() - 2);
                    }
                };
                case Orientation.WEST : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() - 10, port.get_yPosition() + 2, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() - 20, port.get_yPosition() + 2, component.get_width() - 2);
                    }
                };
                case Orientation.EAST : {
                    if (port.get_portDescription() == IOTYPE.D) {
                        drawingAdapter.drawText("D", port.get_xPosition() + 3, port.get_yPosition() + 3, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.CLK) {
                        drawingAdapter.drawText("CLK", port.get_xPosition() + 3, port.get_yPosition() + 3, component.get_width() - 2);
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
            switch(component.get_orientation()){
                case Orientation.NORTH : {
                    if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() - 2, port.get_yPosition() + 10, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() - 6, port.get_yPosition() + 10, component.get_width() - 2);
                    }
                };
                case Orientation.SOUTH : {
                    if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() - 3, port.get_yPosition() - 7, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() - 3, port.get_yPosition() - 7, component.get_width() - 2);
                    }
                };
                case Orientation.WEST : {
                    if (port.get_portDescription() == IOTYPE.Q) {
                        drawingAdapter.drawText("Q", port.get_xPosition() + 3, port.get_yPosition() + 2, component.get_width() - 2);
                    } else if (port.get_portDescription() == IOTYPE.QN) {
                        drawingAdapter.drawText("QN", port.get_xPosition() + 3, port.get_yPosition() + 2, component.get_width() - 2);
                    }
                };
                case Orientation.EAST : {
                    if (port.get_portDescription() == IOTYPE.Q) {
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
