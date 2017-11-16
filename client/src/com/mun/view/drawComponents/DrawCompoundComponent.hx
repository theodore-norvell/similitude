package com.mun.view.drawComponents;
import js.html.CanvasRenderingContext2D;
import com.mun.model.enumeration.BOX;
import com.mun.type.Coordinate;
import com.mun.model.component.Port;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.global.Constant.*;

class DrawCompoundComponent implements DrawComponent{
    var drawingAdapter:DrawingAdapterI;
    var component:Component;
    var drawingAdapterTrans:DrawingAdapterI;
    var context:CanvasRenderingContext2D;

    public function new(component:Component, drawingAdapter:DrawingAdapterI, drawingAdapterTrans:DrawingAdapterI, context:CanvasRenderingContext2D) {
        this.component = component;
        this.drawingAdapter = drawingAdapter;
        this.drawingAdapterTrans = drawingAdapterTrans;
        this.context = context;
    }

    public function drawCorrespondingComponent(strokeColor:String):Void {
        if(strokeColor == null || strokeColor == ""){
            strokeColor = "black";
        }

        for (i in component.get_inportIterator()) {
            var port:Port = i;
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), com.mun.global.Constant.portRadius);
        }
        for (i in component.get_outportIterator()) {
            var port:Port = i;
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), com.mun.global.Constant.portRadius);
        }


        drawingAdapter.setStrokeColor(strokeColor);

        if(component.get_boxType() == BOX.WHITE_BOX ){
            drawingAdapter.setFillColor("white");
        }else{
            drawingAdapter.setFillColor("gray");
        }

        drawingAdapter.drawRect(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());
        drawingAdapter.setClip(component.get_xPosition(), component.get_yPosition(), component.get_width(), component.get_height());


        if(component.get_boxType() == BOX.BLACK_BOX ){
            drawingAdapter.setTextColor("black");
            drawingAdapter.drawText(component.get_name(), component.get_xPosition(), component.get_yPosition(), component.get_width());
        }

        drawInportAndOutport();

        //reset drawing parameter
        drawingAdapter.resetDrawingParam();
    }

    function drawInportAndOutport(){
        //draw inport
        for (i in component.get_inportIterator()) {
            var port:Port = i;
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);

            if(component.get_boxType() == BOX.WHITE_BOX ){
                for(j in component.get_componentKind().getInnerCircuitDiagram().get_componentIterator()){
                    if(j.getNameOfTheComponentKind() == "Input"){
                        if(i.get_sequence() == j.get_componentKind().get_sequence()){
                            for(k in j.get_inportIterator()){
                                //draw a line
                                var coordinate:Coordinate = drawingAdapterTrans.getTransform().pointConvert(new Coordinate(k.get_xPosition(), k.get_yPosition()));
                                coordinate = drawingAdapter.getTransform().pointInvert(coordinate);
                                drawingAdapter.drawLine(i.get_xPosition(), i.get_yPosition(), coordinate.get_xPosition(), coordinate.get_yPosition());

                            }
                        }
                    }
                }
            }
        }

        //draw outport
        for (i in component.get_outportIterator()) {
            var port:Port = i;
            //init set the radius is 2
            drawingAdapter.setFillColor("black");
            drawingAdapter.drawCricle(port.get_xPosition(), port.get_yPosition(), portRadius);

            if(component.get_boxType() == BOX.WHITE_BOX){
                for(j in component.get_componentKind().getInnerCircuitDiagram().get_componentIterator()){
                    if(j.getNameOfTheComponentKind() == "Output"){
                        if(i.get_sequence() == j.get_componentKind().get_sequence()){
                            for(k in j.get_outportIterator()){
                                //draw a line
                                var coordinate:Coordinate = drawingAdapterTrans.getTransform().pointConvert(new Coordinate(k.get_xPosition(), k.get_yPosition()));
                                coordinate = drawingAdapter.getTransform().pointInvert(coordinate);
                                drawingAdapter.drawLine(i.get_xPosition(), i.get_yPosition(), coordinate.get_xPosition(), coordinate.get_yPosition());

                            }
                        }
                    }
                }
            }
        }
    }
}
