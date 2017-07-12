package com.mun.controller.mouseAction;

import com.mun.view.drawingImpl.Transform;
import com.mun.view.drawingImpl.ViewToWorld;
import com.mun.view.drawingImpl.ViewToWorldI;
import js.Browser;
import js.html.KeyboardEvent;
import com.mun.model.component.Port;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Component;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.model.component.Link;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import js.html.MouseEvent;
import com.mun.type.Coordinate;
import js.html.CanvasElement;
import com.mun.type.LinkAndComponentAndEndpointArray;
import com.mun.type.LinkAndComponentArray;

class CanvasListener {
    var canvas:CanvasElement;
    var mouseDownFlag:Bool = false;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var mouseDownLocation:Coordinate;
    var updateToolBar:UpdateToolBar;
    //local varible
    var link:Link;
    var hightLightLink:Link;
    var linkHighLight:Bool = false;
    var createLinkFlag:Bool = false;
    var component:Component;
    var endpoint:Endpoint;
    var endpointSelected:Bool = false;
    var port:Port;
    //for move multipile objects
    var linkAndComponentArray:LinkAndComponentArray = new LinkAndComponentArray();
    var  linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointArray = new LinkAndComponentAndEndpointArray();
    //key
    var altKeyFlag:Bool = false;

    //button click flag
    var buttonClickFlag:Bool = false;

    var viewToWorld:ViewToWorldI;

    public function new(canvas:CanvasElement, updateCircuitDiagram:UpdateCircuitDiagram, updateToolBar:UpdateToolBar) {
        this.canvas = canvas;
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.updateToolBar = updateToolBar;

        viewToWorld = new ViewToWorld(updateCircuitDiagram.get_transform());
        //add mouse down listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);

        Browser.document.addEventListener("keydown", keyDown, false);
        Browser.document.addEventListener("keyup", keyUp, false);

        linkAndComponentArrayReset();
    }

    public function getPointOnCanvas(canvas:CanvasElement, x:Float, y:Float):Coordinate {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Coordinate = new Coordinate(0, 0);
        coordinate.set_xPosition((x - bbox.left) * (canvas.width  / bbox.width));
        coordinate.set_yPosition((y - bbox.top)  * (canvas.height / bbox.height));//view coordinate

        //TODO translate view coordinate to world coordinate
        //coordinate = viewToWorld.convertCoordinate(coordinate);

        return coordinate;
    }

    public function doMouseDown(event:MouseEvent){
        setButtonClickFlagFlase();
        if(!altKeyFlag){
            linkAndComponentArrayReset();
        }
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
        var endpointArray:Array<Endpoint> = updateCircuitDiagram.getEndpoint(mouseDownLocation);
        if(endpointArray.length != 0){
            if(hightLightLink != null){
                for(i in endpointArray){
                    if(i == hightLightLink.get_leftEndpoint()){
                        endpoint = i;
                        break;
                    }

                    if(i == hightLightLink.get_rightEndpoint()){
                        endpoint = i;
                        break;
                    }
                }
            }
            if(endpoint == null){
                for(i in endpointArray){
                    endpoint = i;
                    break;
                }
            }
        }

        if(endpoint != null){
            endpointSelected = true;
        }else{
            endpointSelected = false;
        }
        if(endpoint == null){
            link = updateCircuitDiagram.getLink(mouseDownLocation);
            if(link == null){//if this mouse location on the link, should be select link first
                component = updateCircuitDiagram.getComponent(mouseDownLocation);
                if(component != null && altKeyFlag){
                    if(linkAndComponentArray.get_componentArray().indexOf(component) == -1){
                        linkAndComponentArray.addComponent(component);
                    }
                }else if(component != null){
                    linkAndComponentArray.addComponent(component);
                }
            }else{
                linkHighLight = true;
                hightLightLink = link;
                if(altKeyFlag){
                    if(linkAndComponentArray.get_componentArray().indexOf(component) == -1){
                        linkAndComponentArray.addLink(link);
                    }
                }else{
                    linkAndComponentArray.addLink(link);
                }
            }
        }

        updateCircuitDiagram.hightLightObject(linkAndComponentArray);
        if((linkAndComponentArray.get_componentArray() != null && linkAndComponentArray.get_componentArray().length != 0)
        || (linkAndComponentArray.get_linkArray() != null && linkAndComponentArray.get_linkArray().length != 0)){
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
        if(link == null && updateCircuitDiagram.isOnPort(mouseDownLocation).get_port() != null){
            link = updateCircuitDiagram.addLink(mouseDownLocation,mouseDownLocation);
            hightLightLink = link;
            linkHighLight = true;
            createLinkFlag = true;
        }
    }

    public function doMouseMove(event:MouseEvent){
        var x:Float = event.clientX;
        var y:Float = event.clientY;
        var loc:Coordinate = getPointOnCanvas(canvas,x,y);
        if(buttonClickFlag){
            mouseDownLocation = loc;
            updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation, true);
        }else if(mouseDownFlag == true){//mouse down efect
            linkAndComponentAndEndpointArrayReset();
            if(createLinkFlag){//link has been created, so move this endpoint
                //if the mouse position have a endpoint
                linkAndComponentAndEndpointArray.addEndpoint(link.get_rightEndpoint());
                updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation, false);
            }else{
                if(endpoint != null){
                    linkAndComponentAndEndpointArray.addEndpoint(endpoint);
                    updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation, false);
                }else if((linkAndComponentArray.get_linkArray() != null && linkAndComponentArray.get_linkArray().length != 0) ||
                (linkAndComponentArray.get_componentArray() != null && linkAndComponentArray.get_componentArray().length != 0)){
                    linkAndComponentAndEndpointArray.set_componentArray(linkAndComponentArray.get_componentArray());
                    linkAndComponentAndEndpointArray.set_linkArray(linkAndComponentArray.get_linkArray());
                    updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointArray,loc, mouseDownLocation, false);
                }
            }

        }
        mouseDownLocation = loc;
    }
    public function doMouseUp(event:MouseEvent){
        mouseDownFlag = false;
        component = null;
        endpoint = null;
        link = null;
        port = null;
        createLinkFlag = false;
        updateCircuitDiagram.resetCommandManagerRecordFlag();

        updateCircuitDiagram.update();
    }

    public function keyDown(event:KeyboardEvent){
        if(event.altKey){
            altKeyFlag = true;
        }
    }

    public function keyUp(event:KeyboardEvent){
        altKeyFlag = false;
    }

    public function linkAndComponentArrayReset(){
        linkAndComponentArray.clean();
    }

    public function linkAndComponentAndEndpointArrayReset(){
        linkAndComponentAndEndpointArray.clean();
    }

    public function setButtonClick(component:Component){
        linkAndComponentAndEndpointArrayReset();
        buttonClickFlag = true;
        linkAndComponentAndEndpointArray.addComponent(component);
        updateCircuitDiagram.createComponentByCommand(component);
    }

    public function setButtonClickFlagFlase(){
        buttonClickFlag = false;
    }
}
