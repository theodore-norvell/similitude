package model.drawComponents;

import model.component.Component;
import model.component.Port;
import model.drawingInterface.DrawingAdapterI;
import global.Constant.*;
/**
* draw input gate
* @author wanhui
**/
class DrawConnector extends DrawComponent{

    public function new(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool ) {
        super( component, drawingAdapter, highlight ) ;
    }

    public function drawCorrespondingComponent() : Void {
        this.setColor() ;
        //set the radius equal to 7
        drawingAdapter.setFillColor("white"); 
        drawingAdapter.drawCircle(component.get_xPosition(), component.get_yPosition(), 7);
        drawingAdapter.setTextColor("black");
        drawingAdapter.drawText( component.getName(),
                                 component.get_yPosition(),
                                 component.get_yPosition(),
                                 component.get_width() - 2) ;
        this.drawPorts( ) ;

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

}
