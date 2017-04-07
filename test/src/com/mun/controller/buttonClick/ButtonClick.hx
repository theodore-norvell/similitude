package com.mun.controller.buttonClick;

import com.mun.controller.createComponent.CreateAndDraw;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.Orientation;
import js.Browser;
class ButtonClick {
    var drawingAdapter:DrawingAdapterI;

    public function new(drawingAdapter:DrawingAdapterI) {
        this.drawingAdapter = drawingAdapter;

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
        new CreateAndDraw("AND",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function flipFlopOnClick(){
        new CreateAndDraw("FlipFlop",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function inputOnClick(){
        new CreateAndDraw("Input",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function muxOnClick(){
        new CreateAndDraw("MUX",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function nandOnClick(){
        new CreateAndDraw("NAND",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function norOnClick(){
        new CreateAndDraw("NOR",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function notOnClick(){
        new CreateAndDraw("NOT",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function orOnClick(){
        new CreateAndDraw("OR",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function outputOnClick(){
        new CreateAndDraw("Output",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
    public function xorOnClick(){
        new CreateAndDraw("XOR",250, 50, 40, 40, Orientation.EAST, 2, drawingAdapter);
    }
}
