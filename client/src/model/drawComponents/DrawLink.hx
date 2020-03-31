package model.drawComponents;

import model.component.Endpoint;
import model.component.Link;
import model.drawingInterface.DrawingAdapterI;
import global.Constant.portRadius ;
/**
* draw link
**/
class DrawLink {
    var drawingAdapter:DrawingAdapterI;
    var link:Link;
    var highlight : Bool ;

    public function new(link:Link, drawingAdapter:DrawingAdapterI, highlight : Bool) {
        this.link = link;
        this.drawingAdapter = drawingAdapter;
    }

    public function drawCorrespondingComponent():Void {
        var color = if( highlight ) "red" else "black" ;
        drawingAdapter.setStrokeColor(color);
        var zero = link.get_leftEndpoint() ;
        var one = link.get_rightEndpoint() ;
        drawingAdapter.drawLine( zero.get_xPosition(),
                                zero.get_yPosition(),
                                one.get_xPosition(),
                                one.get_yPosition() );
        drawEndpoint(zero) ;
        drawEndpoint(one) ;
    }

    private function drawEndpoint( endpoint : Endpoint ) : Void {
        drawingAdapter.setStrokeColor( "black" ) ;
        drawingAdapter.setFillColor("white");
        if( endpoint.isConnected() ) {
            drawingAdapter.drawRect(endpoint.get_xPosition(), endpoint.get_yPosition(), portRadius, portRadius); }
    }

}
