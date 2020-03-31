package model.drawComponents;

import global.Constant.*;
import model.component.Component;
import model.component.Port;
import model.drawingInterface.DrawingAdapterI;
/**
* draw and gate
* @author wanhui
  TODO Consoldate all this drawing code into one class
**/
class DrawAND extends DrawComponent{

    public function new(component:Component, drawingAdapter:DrawingAdapterI, highlight : Bool ) {
        super( component, drawingAdapter, highlight ) ;
    }

    public function drawCorrespondingComponent() : Void {
        this.setColor() ;
        drawingAdapter.drawAndShape(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height(), component.get_orientation());
        this.drawPorts() ;
        drawingAdapter.resetDrawingParam();
    }

}
