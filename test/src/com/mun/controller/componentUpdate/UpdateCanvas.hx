package com.mun.controller.componentUpdate;

import com.mun.view.drawingImpl.Transform;
import com.mun.view.drawingImpl.DrawingAdapter;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.component.CircuitDiagramI;
import com.mun.global.Constant.*;
/**
* update the canvas
**/
class UpdateCanvas {
    var circuitDiagram:CircuitDiagramI;
    var transform:Transform;

    public function new(circuitDiagram:CircuitDiagramI, transform:Transform) {
        this.circuitDiagram = circuitDiagram;
        this.transform = transform;
    }
    public function update(?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        //clear the canvas
        CANVAS.width = CANVAS.width;

        circuitDiagram.draw(new DrawingAdapter(transform),linkAndComponentArray);
    }

}
