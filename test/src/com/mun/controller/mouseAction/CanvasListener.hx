package com.mun.controller.mouseAction;

import com.mun.model.component.Port;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Component;
import com.mun.controller.componentUpdate.UpdateToolBar;
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
    var updateToolBar:UpdateToolBar;
    //local varible
    var link:Link;
    var createLinkFlag:Bool = false;
    var object:Object;
    var component:Component;
    var endpoint:Endpoint;
    var port:Port;

    public function new(canvas:CanvasElement, updateCircuitDiagram:UpdateCircuitDiagram, updateToolBar:UpdateToolBar) {
        this.canvas = canvas;
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.updateToolBar = updateToolBar;
        //add mouse down listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);
    }

    public function getPointOnCanvas(canvas:CanvasElement, x:Float, y:Float):Coordinate {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Coordinate = {"xPosition":0,"yPosition":0};
        coordinate.xPosition = (x - bbox.left) * (canvas.width  / bbox.width);
        coordinate.yPosition = (y - bbox.top)  * (canvas.height / bbox.height);
        return coordinate;
    }

    public function doMouseDown(event:MouseEvent){

        //initialize object
        object =  {"link":null,"component":null,"endPoint":null, "port":null};
        doMouseUp(event);
        //initial end

        var x:Float = event.clientX;
        var y:Float = event.clientY;
        mouseDownLocation = getPointOnCanvas(canvas,x,y);
        mouseDownFlag = true;//mouse down flag

        //get the component or link on this mouse location
        link = updateCircuitDiagram.getLink(mouseDownLocation);
        object.link = link;
        if(link == null){//if this mouse location on the link, should be select link first
            component = updateCircuitDiagram.getComponent(mouseDownLocation);
            object.component = component;
        }

        updateCircuitDiagram.hightLightObject(object);
        if(object.component != null || object.link != null){
            updateToolBar.update(object);
        }else{
            updateToolBar.hidden();
        }

        //if link has been selected, then prepare the endpoint
        if(object.link != null){
            endpoint = updateCircuitDiagram.getEndpoint(mouseDownLocation);
            return;
        }
        if(link == null && updateCircuitDiagram.isOnPort(mouseDownLocation).port != null){
            link = updateCircuitDiagram.addLink(mouseDownLocation,mouseDownLocation);
            createLinkFlag = true;
        }
    }

    public function doMouseMove(event:MouseEvent){
        var x:Float = event.clientX;
        var y:Float = event.clientY;
        var loc:Coordinate = getPointOnCanvas(canvas,x,y);
        if(mouseDownFlag == true){//mouse down efect

            if(createLinkFlag){//link has been created, so move this endpoint
                //if the mouse position have a endpoint
                updateCircuitDiagram.moveEndpoint(loc, link.get_rightEndpoint());
            }else{
                if(component != null){
                    //move component
                    updateCircuitDiagram.moveComponent(component,loc, mouseDownLocation);
                }

                if(link != null){
                    updateCircuitDiagram.moveLink(link,loc, mouseDownLocation);
                }
            }

        }
        mouseDownLocation = loc;
    }
    public function doMouseUp(event:MouseEvent){
        mouseDownFlag = false;
        link = null;
        component = null;
        endpoint = null;
        port = null;
        createLinkFlag = false;
    }
}
