package com.mun.controller.mouseAction;
import js.html.MouseEvent;
import com.mun.type.Type.Cooridnate;
import js.html.CanvasElement;
class CanvasListener {
    var canvas:CanvasElement;

    public function new(canvas:CanvasElement) {
        this.canvas = canvas;
        //add mouse down listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);
    }

    public function getPointOnCanvas(canvas:CanvasElement, x:Float, y:Float) {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Cooridnate = {"xPosition":0,"yPosition":0};
        coordinate.xPosition = x - bbox.left * (canvas.width  / bbox.width);
        coordinate.yPosition = y - bbox.top  * (canvas.height / bbox.height);
        return coordinate;
    }
    public function doMouseDown(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        var loc:Cooridnate = getPointOnCanvas(canvas,x,y);
        trace(loc.xPosition + "   " + loc.yPosition);
    }
    public function doMouseMove(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        var loc:Cooridnate = getPointOnCanvas(canvas,x,y);
    }
    public function doMouseUp(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        var loc:Cooridnate = getPointOnCanvas(canvas,x,y);
    }
}
