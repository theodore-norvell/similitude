package com.mun.controller.componentUpdate;

import com.mun.type.Type.Object;
import com.mun.type.Type.LinkAndComponentArray;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.CircuitDiagramI;
import js.html.CanvasElement;
/**
* update the canvas
**/
class UpdateCanvas {
    var canvas:CanvasElement;
    var circuitDiagram:CircuitDiagramI;
    var drawingAdapter:DrawingAdapterI;

    public function new(canvas:CanvasElement,circuitDiagram:CircuitDiagramI,drawingAdapter:DrawingAdapterI) {
        this.canvas = canvas;
        this.circuitDiagram = circuitDiagram;
        this.drawingAdapter = drawingAdapter;
    }
    public function update(?linkAndComponentArray:LinkAndComponentArray){
               //clear the canvas
        canvas.width = canvas.width;

        circuitDiagram.draw(linkAndComponentArray, drawingAdapter);
    }

}
