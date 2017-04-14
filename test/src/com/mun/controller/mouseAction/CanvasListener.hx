package com.mun.controller.mouseAction;

import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import js.html.MouseEvent;
import com.mun.type.Type.Coordinate;
import js.html.CanvasElement;

class CanvasListener {
    var canvas:CanvasElement;
    var mouseDownFlag:Bool = false;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var mouseDownLocation:Coordinate;

    public function new(canvas:CanvasElement, updateCircuitDiagram:UpdateCircuitDiagram) {
        this.canvas = canvas;
        this.updateCircuitDiagram = updateCircuitDiagram;
        //add mouse down listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);
    }

    public function getPointOnCanvas(canvas:CanvasElement, x:Float, y:Float) {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Coordinate = {"xPosition":0,"yPosition":0};
        coordinate.xPosition = x - bbox.left * (canvas.width  / bbox.width);
        coordinate.yPosition = y - bbox.top  * (canvas.height / bbox.height);
        return coordinate;
    }
    public function doMouseDown(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        mouseDownLocation = getPointOnCanvas(canvas,x,y);
        mouseDownFlag = true;
    }
    public function doMouseMove(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        var loc:Coordinate = getPointOnCanvas(canvas,x,y);
        if(mouseDownFlag == true){//mouse down efect
            //if mouse on the port, draw link or move endpoint
            if(updateCircuitDiagram.portAction(loc).endPoint != null){
                //if the mouse position have a endpoint

            }else{
                //the mouse position does not have a endpoint

            }
            //if mouse not on the port, it is on the component
            updateCircuitDiagram.moveComponent(loc);
        }
    }
    public function doMouseUp(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        var loc:Coordinate = getPointOnCanvas(canvas,x,y);
        mouseDownFlag = false;
    }
}
