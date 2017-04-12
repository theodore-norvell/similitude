package com.mun.controller.mouseAction;

import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.Orientation;
import js.Browser;
class ButtonClick {
    var drawingAdapter:DrawingAdapterI;
    var updateCircuitDiagram:UpdateCircuitDiagram;

    public function new(drawingAdapter:DrawingAdapterI,updateCircuitDiagram:UpdateCircuitDiagram) {
        this.drawingAdapter = drawingAdapter;
        this.updateCircuitDiagram = updateCircuitDiagram;

        Browser.document.getElementById("AND").onclick = andOnClick;
        Browser.document.getElementById("FlipFlop").onclick = flipFlopOnClick;
        Browser.document.getElementById("INPUT").onclick = inputOnClick;
        Browser.document.getElementById("MUX").onclick = muxOnClick;
        Browser.document.getElementById("NAND").onclick = nandOnClick;
        Browser.document.getElementById("NOR").onclick = norOnClick;
        Browser.document.getElementById("NOT").onclick = notOnClick;
        Browser.document.getElementById("OR").onclick = orOnClick;
        Browser.document.getElementById("OUTPUT").onclick = outputOnClick;
        Browser.document.getElementById("XOR").onclick = xorOnClick;
    }

    public function andOnClick(){
        updateCircuitDiagram.createComponentByButton("AND",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function flipFlopOnClick(){
        updateCircuitDiagram.createComponentByButton("FlipFlop",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function inputOnClick(){
        updateCircuitDiagram.createComponentByButton("Input",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function muxOnClick(){
        updateCircuitDiagram.createComponentByButton("MUX",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function nandOnClick(){
        updateCircuitDiagram.createComponentByButton("NAND",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function norOnClick(){
        updateCircuitDiagram.createComponentByButton("NOR",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function notOnClick(){
        updateCircuitDiagram.createComponentByButton("NOT",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function orOnClick(){
        updateCircuitDiagram.createComponentByButton("OR",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function outputOnClick(){
        updateCircuitDiagram.createComponentByButton("Output",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function xorOnClick(){
        updateCircuitDiagram.createComponentByButton("XOR",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
}
