package model.drawComponents;

import model.component.Component;
import model.drawingInterface.DrawingAdapterI;
import global.Constant.portSize ;

class DrawComponent {

    var drawingAdapter:DrawingAdapterI;
    var component:Component;
    var highlight : Bool ;

    public function new(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool ) {
        this.component = component;
        this.drawingAdapter = drawingAdapter;
        this.highlight = highlight ;
    }

    private function setColor( ) : Void {
        if( highlight ) drawingAdapter.setStrokeColor( "red" ) ;
        else drawingAdapter.setStrokeColor( "black" ) ;
        drawingAdapter.setFillColor("white");
    }

    private function drawPorts( ) : Void {
        // TODO. Draw the text associated with each input, if any.
        // TODO. Draw pigtails for ports.
        // TODO. Change color for selected ports
        drawingAdapter.setStrokeColor( "blue" ) ;
        drawingAdapter.setFillColor("blue");
        for (port in component.get_ports()) {
            if( ! port.isConnected() ) {
                drawingAdapter.drawRect(port.get_xPosition(), port.get_yPosition(), portSize, portSize); }

            trace( "drawing port" ) ;
        }
    }
}
