package com.mun.controller.componentUpdate;

import com.mun.view.drawComponents.DrawLink;
import com.mun.type.Type.Object;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.CircuitDiagram;
import js.html.CanvasElement;
/**
* update the canvas
**/
class UpdateCanvas {
    var canvas:CanvasElement;
    var circuit:CircuitDiagram;
    var drawingAdapter:DrawingAdapterI;

    public function new(canvas:CanvasElement,circuitDiagram:CircuitDiagram,drawingAdapter:DrawingAdapterI) {
        this.canvas = canvas;
        this.circuit = circuitDiagram;
        this.drawingAdapter = drawingAdapter;
    }
    public function getcircuit():CircuitDiagram{
        return circuit;
    }

    public function update(?object:Object){
        //clear the canvas
        canvas.width = canvas.width;
        //update component array
        for(i in 0...circuit.get_componentArray().length){
            if(object != null && object.component != null && object.component == circuit.get_componentArray()[i]){
                circuit.get_componentArray()[i].drawComponent(circuit.get_componentArray()[i], drawingAdapter, true);
            }else{
                circuit.get_componentArray()[i].drawComponent(circuit.get_componentArray()[i], drawingAdapter, false);
            }
        }
        //update link array
        for(i in 0...circuit.get_linkArray().length){
            var drawComponent:DrawComponent = new DrawLink(circuit.get_linkArray()[i], drawingAdapter);
            if(object != null && object.link != null && object.link == circuit.get_linkArray()[i]){
                drawComponent.drawCorrespondingComponent("red");
            }else{
                drawComponent.drawCorrespondingComponent("black");
            }
        }
    }

}
