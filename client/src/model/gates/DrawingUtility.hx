package model.gates ;

import model.component.*;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.Box ;
import model.enumeration.Orientation ;
import model.enumeration.IOTYPE ;
import type.Coordinate ;

class DrawingUtility {

    public static function drawAnd(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter ) ;
        drawingAdapter.drawAndShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        drawPorts( component, drawingAdapter, highlight ) ;
        drawingAdapter.resetDrawingParam();
    }

    public static function drawCompoundComponent(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool, drawingAdapterTrans:DrawingAdapterI) : Void {
        setColor( highlight, drawingAdapter ) ;

        if(component.get_boxType() == Box.WHITE_BOX ){
            drawingAdapter.setFillColor("white");
        }else{
            drawingAdapter.setFillColor("gray");
        }

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setClip(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());

        if(component.get_boxType() == Box.BLACK_BOX ){
            drawingAdapter.setTextColor("black");
            drawingAdapter.drawText(component.getName(), component.get_xPosition(), component.get_yPosition(), component.get_width());
        }

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    public static function drawConnector(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter )  ;
        //set the radius equal to 7
        drawingAdapter.setFillColor("white"); 
        drawingAdapter.drawCircle(component.get_xPosition(), component.get_yPosition(), 7);
        drawingAdapter.setTextColor("black");
        drawingAdapter.drawText( component.getName(),
                                 component.get_yPosition(),
                                 component.get_yPosition(),
                                 component.get_width() - 2) ;
        drawPorts( component, drawingAdapter, highlight ) ;

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    public static function drawFlipFlopComponent(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter )  ;

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.drawText("FF", component.get_xPosition() - 4, component.get_yPosition(), component.get_width());
        // Draw the ports
        drawPorts( component, drawingAdapter, highlight ) ;
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

    public static function drawMUX(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter )  ;

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setTextColor("black");
        drawingAdapter.drawText("MUX", component.get_xPosition(), component.get_yPosition(), component.get_width());

        // Draw the ports.
        drawPorts( component, drawingAdapter, highlight ) ;


        // TODO Put this all in one place.
        drawingAdapter.setTextColor("black");
        for (port in component.get_ports()) {
            //draw text
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
        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    public static function drawNot(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter )  ;

        drawingAdapter.drawNotShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        
        drawPorts( component, drawingAdapter, highlight ) ;

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    public static function drawOr(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter )  ;

        drawingAdapter.drawOrShape(component.get_xPosition(),
                                    component.get_yPosition(),
                                    component.get_width(),
                                    component.get_height(),
                                    component.get_orientation());
        drawPorts( component, drawingAdapter, highlight ) ;
    }

    public static function drawXOr(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) : Void {
        setColor( highlight, drawingAdapter )  ;
        drawingAdapter.drawXorShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        drawPorts( component, drawingAdapter, highlight ) ;
        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    public static function drawLink(link:Link, drawingAdapter:DrawingAdapterI, highlight : Bool):Void {
        var color = if( highlight ) "red" else "black" ;
        drawingAdapter.setStrokeColor(color);
        var zero = link.get_endpoint(0) ;
        var one = link.get_endpoint(1) ;
        drawingAdapter.drawLine( zero.get_xPosition(),
                                zero.get_yPosition(),
                                one.get_xPosition(),
                                one.get_yPosition() );
        drawEndpoint(zero, drawingAdapter, highlight) ;
        drawEndpoint(one, drawingAdapter, highlight) ;
    }

    private static function drawEndpoint( endpoint : Endpoint, drawingAdapter:DrawingAdapterI, highlight : Bool ) : Void {
        var joinRadius = 3 ;
        var connection = endpoint.getConnection() ;
        if( highlight ) {
            drawingAdapter.setStrokeColor( "red" ) ;
            drawingAdapter.setFillColor("red" );
            drawingAdapter.drawCircle(endpoint.get_xPosition(), endpoint.get_yPosition(), global.Constant.joinRadius);
        } else if( ! connection.aPortIsConnected() && connection.get_count() != 2 ) {
            drawingAdapter.setStrokeColor( "black" ) ;
            if( endpoint.isConnected() ) {
                drawingAdapter.setFillColor("black"); }
            else {
                drawingAdapter.setFillColor("white"); }
            drawingAdapter.drawCircle(endpoint.get_xPosition(), endpoint.get_yPosition(), global.Constant.joinRadius);
        }
    }

    private static function setColor( highlight : Bool, drawingAdapter:DrawingAdapterI ) : Void {
        if( highlight ) drawingAdapter.setStrokeColor( "red" ) ;
        else drawingAdapter.setStrokeColor( "black" ) ;
        drawingAdapter.setFillColor("white");
    }

    private static function drawPorts( component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool ) : Void {
        // TODO. Draw the text associated with each input, if any.
        // TODO. Draw pigtails for ports.
        drawingAdapter.setStrokeColor( if(highlight) "red" else "black" ) ;
        for (port in component.get_ports()) {
            if( port.isConnected() ) {
                drawingAdapter.setFillColor( if(highlight) "red" else "black" ); }
            else {
                drawingAdapter.setFillColor("white"); }
            drawingAdapter.drawRect(port.get_xPosition(), port.get_yPosition(), global.Constant.portSize, global.Constant.portSize);
        }
    }
    
    public static function connectPortsToConnectors(component:Component, drawingAdapter:DrawingAdapterI, higlight : Bool, drawingAdapterTrans:DrawingAdapterI) : Void {
        for(port in component.get_ports()) {

            // If in White box, mode, try to draw a line from the port of the compound port to
            // the connector with the same sequence number in the inner drawing.
            // TODO Clean this up.
            // TODO: For black box mode, draw the name of the port instead,
            for(j in component.get_componentKind().getInnerCircuitDiagram().get_componentIterator()) {
                if(j.getNameOfTheComponentKind() == "Connector" ) {
                    if(port.get_sequence() == j.get_sequence()) {
                        for(k in j.get_ports()) {
                            //draw a line
                            var coordinate:Coordinate = drawingAdapterTrans.getTransform().pointConvert(new Coordinate(k.get_xPosition(), k.get_yPosition()));
                            coordinate = drawingAdapter.getTransform().pointInvert(coordinate);
                            drawingAdapter.drawLine(port.get_xPosition(), port.get_yPosition(), coordinate.get_xPosition(), coordinate.get_yPosition());
                        }
                    }
                }
            }
        }
    }
}
