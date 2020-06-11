package model.drawComponents;

import model.component.Endpoint;
import model.component.Link;
import model.drawingInterface.DrawingAdapterI;
import global.Constant.portSize ;
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
        this.highlight = highlight ;
    }

    public function drawCorrespondingComponent():Void {
        var color = if( highlight ) "red" else "black" ;
        drawingAdapter.setStrokeColor(color);
        var zero = link.get_endpoint(0) ;
        var one = link.get_endpoint(1) ;
        drawingAdapter.drawLine( zero.get_xPosition(),
                                zero.get_yPosition(),
                                one.get_xPosition(),
                                one.get_yPosition() );
        drawEndpoint(zero) ;
        drawEndpoint(one) ;
    }

    private function drawEndpoint( endpoint : Endpoint ) : Void {
        drawingAdapter.setStrokeColor( "black" ) ;
        if( endpoint.isConnected() ) {
            drawingAdapter.setFillColor("black"); }
        else {
            drawingAdapter.setFillColor("white"); }
        drawingAdapter.drawRect(endpoint.get_xPosition(), endpoint.get_yPosition(), portSize, portSize);
    }

}
