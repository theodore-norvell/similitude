package com.mun.controller.controllerState;

import com.mun.model.component.CircuitDiagramI;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.model.component.Endpoint;
import com.mun.controller.mouseAction.ButtonClick;
import com.mun.model.enumeration.KEY;
import com.mun.model.enumeration.K_STATE;
import com.mun.model.component.Link;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.enumeration.M_STATE;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.type.WorldPoint;
import com.mun.model.enumeration.MODE;
import com.mun.view.drawingImpl.Transform;
import com.mun.view.drawingImpl.ViewToWorld;
import com.mun.view.drawingImpl.ViewToWorldI;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.type.Coordinate;
import js.html.MouseEvent;
import js.html.CanvasElement;
import com.mun.model.enumeration.C_STATE;
class ControllerCanvasContext {
    var canvas:CanvasElement;
    var circuitDiagram:CircuitDiagramI;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var keyState:KeyState;
    var buttonClick:ButtonClick;
    var updateToolBar:UpdateToolBar;

    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;
    var lastClickArray:LinkAndComponentAndEndpointAndPortArray;
    var worldPointArray:Array<WorldPoint>;
    var mouseDownWorldCoordinate:Coordinate;
    var mouseMoveWorldCoordiante:Coordinate;

    var viewToWorld:ViewToWorldI;
    var transform:Transform;

    var lastState:C_STATE;
    var controllerState:C_STATE;
    var mouseState:M_STATE;
    var mode:MODE;
    var pointMode:POINT_MODE;

    var hightLightLink:Link;

    public function new(canvas:CanvasElement, circuitDiagram:CircuitDiagramI, updateCircuitDiagram:UpdateCircuitDiagram, buttonClick:ButtonClick, upateToolBar:UpdateToolBar) {
        this.canvas = canvas;
        this.circuitDiagram = circuitDiagram;
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.buttonClick = buttonClick;
        this.updateToolBar = upateToolBar;

        controllerState = C_STATE.IDLE;
        lastState = C_STATE.IDLE;

        mode = MODE.EXCLUDE_PARENTS;
        pointMode = POINT_MODE.ONE;
        mouseState = M_STATE.IDLE;
        transform = Transform.identity();

        viewToWorld = new ViewToWorld(transform);
        keyState = new KeyState();
        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
        lastClickArray = new LinkAndComponentAndEndpointAndPortArray();

        //add mouse  listener
        canvas.addEventListener("mousedown", doMouseDown,false);
        canvas.addEventListener("mousemove", doMouseMove,false);
        canvas.addEventListener("mouseup", doMouseUp,false);
    }

    public function get_controllerState():C_STATE {
        return controllerState;
    }

    public function set_controllerState(value:C_STATE) {
        lastState = controllerState;
        this.controllerState = value;
        checkState();
    }

    function getPointOnCanvas(x:Float, y:Float):Coordinate {
        var bbox = canvas.getBoundingClientRect();
        var coordinate:Coordinate = new Coordinate(0, 0);
        coordinate.set_xPosition((x - bbox.left) * (canvas.width  / bbox.width));
        coordinate.set_yPosition((y - bbox.top)  * (canvas.height / bbox.height));
        return coordinate;//this is view coordinate
    }

    function doMouseDown(event:MouseEvent){
        var x:Float = event.clientX;
        var y:Float = event.clientY;
        var mouseDownLocation:Coordinate = getPointOnCanvas(x,y);

        //translate view coordinate to world coordinate
        mouseDownWorldCoordinate = viewToWorld.convertCoordinate(mouseDownLocation);

        mouseState = M_STATE.MOUSE_DOWN;

        mouseDownProcess();
    }

    function doMouseUp(event:MouseEvent){

        mouseState = M_STATE.MOUSE_UP;

        updateCircuitDiagram.resetCommandManagerRecordFlag();

        lastState = controllerState;
        controllerState = C_STATE.IDLE;
        checkState();

        //redraw canvas
        updateCircuitDiagram.update();
    }

    function doMouseMove(event:MouseEvent){
        var x:Float = event.clientX;
        var y:Float = event.clientY;
        var mouseMoveLocation:Coordinate = getPointOnCanvas(x,y);

        //translate to world coordinate
        mouseMoveWorldCoordiante = viewToWorld.convertCoordinate(mouseMoveLocation);

        mouseMoveResultProcess();

        mouseDownWorldCoordinate = mouseMoveWorldCoordiante;
    }

    function mouseDownProcess(){
        updateCircuitDiagram.resetCommandManagerRecordFlag();

        switch(keyState.get_keyState()){
            case K_STATE.KEY_DOWN : {
                if(keyState.get_key() == KEY.ALT_KEY){
                    lastState = controllerState;
                    controllerState = C_STATE.MULTI_SELECTION;
                }else{
                    lastState = controllerState;
                    controllerState = C_STATE.SINGLE_SELECTION;
                }
            };
            case K_STATE.KEY_UP : {
                lastState = controllerState;
                controllerState = C_STATE.SINGLE_SELECTION;
            };
            case K_STATE.IDLE:{
                lastState = controllerState;
                controllerState = C_STATE.SINGLE_SELECTION;
            };
            default:{
                //won't step into this line
            };
        }
        checkState();
    }

    function mouseMoveResultProcess(){
        /**
        * if controller state change to create_component, then when mouse move into
        * canvas, this component should move with the mouse
        **/
        if(controllerState == C_STATE.CREATE_COMPONENT){
            lastState = controllerState;
            controllerState = C_STATE.MOVE;
            checkState();

            controllerState = C_STATE.CREATE_COMPONENT;
        }else if((controllerState == C_STATE.SINGLE_SELECTION || controllerState == C_STATE.MULTI_SELECTION || controllerState == C_STATE.CREATE_LINK) && mouseState == M_STATE.MOUSE_DOWN){
            lastState = controllerState;
            controllerState = C_STATE.MOVE;
            checkState();
        }else if(controllerState == C_STATE.MOVE && mouseState == M_STATE.MOUSE_DOWN){
            lastState = controllerState;
            controllerState = C_STATE.MOVE;
            checkState();
        }
    }

    function checkHitList(){//
        /**
        * Priority:
        * Port > Endpoint > Component = Link
        * */
        var hitList:LinkAndComponentAndEndpointAndPortArray = circuitDiagram.findHitList(mouseDownWorldCoordinate,mode);
        //worldPointArray = circuitDiagram.findWorldPoint(worldCoordinate, pointMode);

        if(hitList.getPortIteratorLength() != 0 && hitList.getEndppointIteratorLength() == 0){
            //only port slected
            controllerState = C_STATE.CREATE_LINK;
            checkState();
        }else if(hitList.getEndppointIteratorLength() !=0 && hitList.getPortIteratorLength() != 0){//if this point on one endpoint and one port
            var endpoint:Endpoint = hitList.getEndpointFromIndex(0);
            if(updateCircuitDiagram.findLinkThroughEndpoint(endpoint) == hightLightLink){
                linkAndComponentAndEndpointAndPortArray.addEndpoint(endpoint);
            }else{
                controllerState = C_STATE.CREATE_LINK;
                checkState();
            }
        }else if(hitList.getEndppointIteratorLength() != 0 && hitList.getPortIteratorLength() == 0){//endpoint selected
            //only one endpoint can be selected
            linkAndComponentAndEndpointAndPortArray.addEndpoint(hitList.getEndpointFromIndex(0));
        }else if(hitList.getComponentIteratorLength() != 0){//component selected
            linkAndComponentAndEndpointAndPortArray.addComponent(hitList.getComponentFromIndex(0));
        }else if(hitList.getLinkIteratorLength() != 0){//link selected
            var link:Link = hitList.getLinkFromIndex(0);
            hightLightLink = link;
            linkAndComponentAndEndpointAndPortArray.addLink(link);
        }

        updateCircuitDiagram.hightLightObject(linkAndComponentAndEndpointAndPortArray);

        //update tool bar
        toolBarUpdate();
    }

    function checkState(){
        switch(controllerState){
            case C_STATE.IDLE : {
                if(!(keyState.get_key() == KEY.ALT_KEY && keyState.get_keyState() == K_STATE.KEY_DOWN)){
                    lastClickArray.setArray(linkAndComponentAndEndpointAndPortArray);
                    linkAndComponentAndEndpointAndPortArray.clean();
                }
            };
            case C_STATE.CREATE_COMPONENT : {
                updateCircuitDiagram.createComponentByCommand(buttonClick.getComponent());
                linkAndComponentAndEndpointAndPortArray.addComponent(buttonClick.getComponent());
            };
            case C_STATE.CREATE_LINK : {
                var link:Link = updateCircuitDiagram.addLink(mouseDownWorldCoordinate,mouseDownWorldCoordinate);
                linkAndComponentAndEndpointAndPortArray.addEndpoint(link.get_rightEndpoint());
            };
            case C_STATE.MOVE : {
                if(!linkAndComponentAndEndpointAndPortArray.isEmpty()){
                    if(lastState == C_STATE.CREATE_COMPONENT){
                        updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointAndPortArray, mouseMoveWorldCoordiante, mouseMoveWorldCoordiante, true);
                    }else{
                        updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointAndPortArray, mouseMoveWorldCoordiante, mouseDownWorldCoordinate, false);
                    }
                }
            };
            case C_STATE.MULTI_SELECTION : {
                linkAndComponentAndEndpointAndPortArray.setArray(lastClickArray);
                checkHitList();
            };
            case C_STATE.SINGLE_SELECTION : {
                checkHitList();
            };
            default : {
                //no other state
            }
        }
    }

    function toolBarUpdate(){
        if(linkAndComponentAndEndpointAndPortArray.getComponentIteratorLength() !=0 || linkAndComponentAndEndpointAndPortArray.getLinkIteratorLength() != 0){
            updateToolBar.update(linkAndComponentAndEndpointAndPortArray);
        }else{
            updateToolBar.hidden();
        }
    }
}
