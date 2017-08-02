package com.mun.controller.componentUpdate;

import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import com.mun.view.drawingImpl.Transform;
import com.mun.view.drawingImpl.DrawingAdapter;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.component.CircuitDiagramI;
/**
* update the canvas
**/
class UpdateCanvas {
    var circuitDiagram:CircuitDiagramI;
    var transform:Transform;
    var canvas:CanvasElement;
    var context:CanvasRenderingContext2D;

    public function new(circuitDiagram:CircuitDiagramI, transform:Transform, canvas:CanvasElement, context:CanvasRenderingContext2D) {
        this.circuitDiagram = circuitDiagram;
        this.transform = transform;
        this.canvas = canvas;
        this.context = context;
    }
    public function update(?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        //clear the canvas
        canvas.width = canvas.width;

        circuitDiagram.draw(new DrawingAdapter(transform, context),linkAndComponentArray);
    }

}
