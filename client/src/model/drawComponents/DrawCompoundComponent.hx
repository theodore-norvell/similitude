package model.drawComponents;

//import js.html.CanvasRenderingContext2D;
import model.enumeration.BOX;
import type.Coordinate;
import model.component.Port;
import model.drawingInterface.DrawingAdapterI;
import model.component.Component;
import global.Constant.*;

class DrawCompoundComponent extends DrawComponent{

    var drawingAdapterTrans : DrawingAdapterI ;
    public function new(component:Component, drawingAdapter:DrawingAdapterI, higlight : Bool, drawingAdapterTrans:DrawingAdapterI) {
        super( component, drawingAdapter, highlight ) ;
        this.drawingAdapterTrans = drawingAdapterTrans;
    }

    public function drawCorrespondingComponent() : Void {
        this.setColor() ;

        if(component.get_boxType() == BOX.WHITE_BOX ){
            drawingAdapter.setFillColor("white");
        }else{
            drawingAdapter.setFillColor("gray");
        }

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setClip(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());

        if(component.get_boxType() == BOX.BLACK_BOX ){
            drawingAdapter.setTextColor("black");
            drawingAdapter.drawText(component.getName(), component.get_xPosition(), component.get_yPosition(), component.get_width());
        }

        drawPorts() ;

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    override function drawPorts() : Void {
        //draw inport
        for (port in component.get_ports()) {
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawRect(port.get_xPosition(), port.get_yPosition(), portSize, portSize);

            // If in White box, mode, try to draw a line from the port of the compound port to
            // the connector with the same sequence number in the inner drawing.
            // TODO Clean this up.
            // TODO: For black box mode, draw the name of the port instead,
            if(component.get_boxType() == BOX.WHITE_BOX ){
                for(j in component.get_componentKind().getInnerCircuitDiagram().get_componentIterator()){
                    if(j.getNameOfTheComponentKind() == "Connector" ){
                        if(port.get_sequence() == j.get_sequence()){
                            for(k in j.get_ports()){
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
}
