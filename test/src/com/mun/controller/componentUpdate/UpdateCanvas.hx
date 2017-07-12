package com.mun.controller.componentUpdate;

import com.mun.view.drawingImpl.Transform;
import com.mun.view.drawingImpl.DrawingAdapter;
import com.mun.type.LinkAndComponentArray;
import com.mun.model.component.CircuitDiagramI;
import js.html.CanvasElement;
/**
* update the canvas
**/
class UpdateCanvas {
    var canvas:CanvasElement;
    var circuitDiagram:CircuitDiagramI;
    var transform:Transform;

    public function new(canvas:CanvasElement,circuitDiagram:CircuitDiagramI, transform:Transform) {
        this.canvas = canvas;
        this.circuitDiagram = circuitDiagram;
        this.transform = transform;
    }
    public function update(?linkAndComponentArray:LinkAndComponentArray){
        //clear the canvas
        canvas.width = canvas.width;

        circuitDiagram.draw(new DrawingAdapter(transform),linkAndComponentArray);
    }

}
