package com.mun.controller.mouseAction;

import js.html.KeyboardEvent;
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
import com.mun.type.Type.LinkAndComponentAndEndpointArray;
import com.mun.type.Type.LinkAndComponentArray;

class CanvasListener {
    var canvas:CanvasElement;
    var mouseDownFlag:Bool = false;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var mouseDownLocation:Coordinate;
    var updateToolBar:UpdateToolBar;
    //local varible
    var link:Link;
    var linkHighLight:Bool = false;
    var createLinkFlag:Bool = false;
    var component:Component;
    var endpoint:Endpoint;
    var endpointSelected:Bool = false;
    var port:Port;
    //for move multipile objects
    var linkAndComponentArray:LinkAndComponentArray = {"linkArray":null, "componentArray":null};
    var  linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointArray = {"linkArray":null, "componentArray":null, "endpointArray":null};
    //key
    var controlKeyFlag:Bool = false;

    public function new(canvas:CanvasElement, updateCircuitDiagram:UpdateCircuitDiagram, updateToolBar:UpdateToolBar) {
        this.canvas = canvas;
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.updateToolBar = updateToolBar;
        //add mouse down listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);
        canvas.addEventListener("keydown", keyDown, false);
        canvas.addEventListener("keyup", keyUp, false);

        linkAndComponentArrayReset();
    }

    public function getPointOnCanvas(canvas:CanvasElement, x:Float, y:Float):Coordinate {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Coordinate = {"xPosition":0,"yPosition":0};
        coordinate.xPosition = (x - bbox.left) * (canvas.width  / bbox.width);
        coordinate.yPosition = (y - bbox.top)  * (canvas.height / bbox.height);
        return coordinate;
    }

    public function doMouseDown(event:MouseEvent){

        doMouseUp(event);
        //initial end
        //reset commandMananger Flag
        updateCircuitDiagram.resetCommandManagerRecordFlag();
        //end

        var x:Float = event.clientX;
        var y:Float = event.clientY;
        mouseDownLocation = getPointOnCanvas(canvas,x,y);
        mouseDownFlag = true;//mouse down flag

        //get the endpoint or link or component on this mouse location
        //priority: endpint -> link -> component
        endpoint = updateCircuitDiagram.getEndpoint(mouseDownLocation);
        if(endpoint != null){
            endpointSelected = true;
            trace("endpoint selected");
        }else{
            endpointSelected = false;
        }

        if(endpoint == null){
            link = updateCircuitDiagram.getLink(mouseDownLocation);
            linkHighLight = true;
            if(link == null){//if this mouse location on the link, should be select link first
                component = updateCircuitDiagram.getComponent(mouseDownLocation);

                if(component != null && controlKeyFlag){
                    linkAndComponentArray.componentArray.push(component);
                }else if(component != null){
                    linkAndComponentArrayReset();
                    linkAndComponentArray.componentArray.push(component);
                }
            }else{
                if(controlKeyFlag){
                    linkAndComponentArray.linkArray.push(link);
                }else{
                    linkAndComponentArrayReset();
                    linkAndComponentArray.linkArray.push(link);
                }
            }
        }

        updateCircuitDiagram.hightLightObject(linkAndComponentArray);
        if((linkAndComponentArray.componentArray != null && linkAndComponentArray.componentArray.length != 0)
            || (linkAndComponentArray.linkArray != null && linkAndComponentArray.linkArray.length != 0)){
            updateToolBar.update(linkAndComponentArray);
        }else{
            updateToolBar.hidden();
        }
        if(linkHighLight && endpointSelected){
            //if link has been selected and this time endpoint has been selected. then move endpoint, do not create a new link
            linkHighLight = false;
            endpointSelected = false;
            return;
        }
        if(link == null){
            linkHighLight = false;
        }
        if(link == null && updateCircuitDiagram.isOnPort(mouseDownLocation).port != null){
            link = updateCircuitDiagram.addLink(mouseDownLocation,mouseDownLocation);
            createLinkFlag = true;
        }
    }

    public function doMouseMove(event:MouseEvent){
        linkAndComponentAndEndpointArrayReset();
        var x:Float = event.clientX;
        var y:Float = event.clientY;
        var loc:Coordinate = getPointOnCanvas(canvas,x,y);
        if(mouseDownFlag == true){//mouse down efect
            if(createLinkFlag){//link has been created, so move this endpoint
                //if the mouse position have a endpoint
                linkAndComponentAndEndpointArray.endpointArray.push(link.get_rightEndpoint());
//                updateCircuitDiagram.moveEndpoint(link.get_rightEndpoint()get_rightEndpointΩ, loc, mouseDownLocation);
                updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation);
            }else{
                if(endpoint != null){
                    linkAndComponentAndEndpointArray.endpointArray.push(endpoint);
                    updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation);
//                    updateCircuitDiagram.moveEndpoint(endpoint, loc, mouseDownLocation);
                }else if((linkAndComponentArray.linkArray != null && linkAndComponentArray.linkArray.length != 0) ||
                            (linkAndComponentArray.componentArray != null && linkAndComponentArray.componentArray.length != 0)){
                    linkAndComponentAndEndpointArray.componentArray = linkAndComponentArray.componentArray;
                    linkAndComponentAndEndpointArray.linkArray = linkAndComponentArray.linkArray;
                    updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation);
                }
//                if(link != null){
//                    updateCircuitDiagram.moveLink(link,loc, mouseDownLocation);
//                }
//
//                if(component != null){
//                    //move component
//                    updateCircuitDiagram.moveComponent(component,loc, mouseDownLocation);
//                }
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
        updateCircuitDiagram.resetCommandManagerRecordFlag();
        linkAndComponentArrayReset();
    }

    public function keyDown(event:KeyboardEvent){
        var keyName:String = event.key;

        if(keyName == "Control"){
            controlKeyFlag = true;
        }
    }

    public function keyUp(event:KeyboardEvent){
        var keyName:String = event.key;

        if(keyName == "Control"){
            controlKeyFlag = false;
        }
    }

    public function linkAndComponentArrayReset(){
        linkAndComponentArray.linkArray = new Array<Link>();
        linkAndComponentArray.componentArray = new Array<Component>();
    }

    public function linkAndComponentAndEndpointArrayReset(){
        linkAndComponentAndEndpointArray.componentArray = new Array<Component>();
        linkAndComponentAndEndpointArray.linkArray = new Array<Link>();
        linkAndComponentAndEndpointArray.endpointArray = new Array<Endpoint>();
    }
}
