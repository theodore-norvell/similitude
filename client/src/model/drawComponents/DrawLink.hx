package model.drawComponents;

import model.component.Endpoint;
import model.component.Link;
import model.drawingInterface.DrawingAdapterI;
import global.Constant.joinRadius ;
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
        drawEndpoint(zero, highlight) ;
        drawEndpoint(one, highlight) ;
    }

    private function drawEndpoint( endpoint : Endpoint, highlight : Bool ) : Void {
        var connection = endpoint.getConnection() ;
        if( highlight ) {
            drawingAdapter.setStrokeColor( "red" ) ;
            drawingAdapter.setFillColor("red" );
            drawingAdapter.drawCircle(endpoint.get_xPosition(), endpoint.get_yPosition(), joinRadius);
        } else {
            if( connection.aPortIsConnected() ) return ; // Let the port do the drawing.
            if( connection.get_count() == 2 ) return ; // This is a connection of two links.
            drawingAdapter.setStrokeColor( "black" ) ;
            if( endpoint.isConnected() ) {
                drawingAdapter.setFillColor("black"); }
            else {
                drawingAdapter.setFillColor("white"); }
            drawingAdapter.drawCircle(endpoint.get_xPosition(), endpoint.get_yPosition(), joinRadius);
        }
    }

}
