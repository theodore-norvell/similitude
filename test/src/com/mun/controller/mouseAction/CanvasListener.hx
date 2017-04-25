package com.mun.controller.mouseAction;

import com.mun.model.component.Link;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import js.html.MouseEvent;
import com.mun.type.Type.Coordinate;
import js.html.CanvasElement;
import com.mun.type.Type.Object;

class CanvasListener {
    var canvas:CanvasElement;
    var mouseDownFlag:Bool = false;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var mouseDownLocation:Coordinate;
    //local varible
    var link:Link;
    var createLinkFlag:Bool = false;
    var object:Object;

    public function new(canvas:CanvasElement, updateCircuitDiagram:UpdateCircuitDiagram) {
        this.canvas = canvas;
        this.updateCircuitDiagram = updateCircuitDiagram;
        //add mouse down listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);
        canvas.addEventListener("click", doClick,false);
    }

    public function getPointOnCanvas(canvas:CanvasElement, x:Float, y:Float) {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Coordinate = {"xPosition":0,"yPosition":0};
        coordinate.xPosition = x - bbox.left * (canvas.width  / bbox.width);
        coordinate.yPosition = y - bbox.top  * (canvas.height / bbox.height);
        return coordinate;
    }

    public function doClick(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        mouseDownLocation = getPointOnCanvas(canvas,x,y);
        object = updateCircuitDiagram.getComponent(mouseDownLocation);
        updateCircuitDiagram.hightLightObject(object);
        doMouseUp(event);
    }

    public function doMouseDown(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        mouseDownLocation = getPointOnCanvas(canvas,x,y);
        object = updateCircuitDiagram.getComponent(mouseDownLocation);
        mouseDownFlag = true;
        if(updateCircuitDiagram.portAction(mouseDownLocation).port != null){
            link = updateCircuitDiagram.addLink(mouseDownLocation,mouseDownLocation);
            createLinkFlag = true;
        }
    }
    public function doMouseMove(event:MouseEvent){
        var x:Float = event.pageX;
        var y:Float = event.pageY;
        var loc:Coordinate = getPointOnCanvas(canvas,x,y);
        if(mouseDownFlag == true){//mouse down efect
            //if mouse on the port, draw link or move endpoint
//            if(updateCircuitDiagram.portAction(loc).endPoint != null){
            if(createLinkFlag){
                //if the mouse position have a endpoint
                updateCircuitDiagram.moveEndpoint(loc, link.get_rightEndpoint());
            }else{
                //the mouse position does not have a endpoint
                //but the endpoint has been created in the doMouseDown function
                //if mouse not on the port, it is on the component
                updateCircuitDiagram.moveComponent(object,loc);
            }

        }
    }
    public function doMouseUp(event:MouseEvent){
        mouseDownFlag = false;
        link = null;
        createLinkFlag = false;
        object = {"link":null,"component":null,"endPoint":null, "port":null};
    }
}
