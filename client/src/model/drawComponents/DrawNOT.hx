package model.drawComponents;

import model.component.Component;
import model.component.Port;
import model.drawingInterface.DrawingAdapterI;
import global.Constant.*;
/**
* draw not gate
**/
class DrawNOT extends DrawComponent {

    public function new(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool) {
        super( component, drawingAdapter, highlight ) ;
    }

    public function drawCorrespondingComponent() : Void {
        this.setColor() ;

        drawingAdapter.drawNotShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        
        this.drawPorts() ;

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();

    }

}
