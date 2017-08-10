package com.mun.controller.controllerState;

import com.mun.type.Object;
import com.mun.type.WorldPoint;
import com.mun.controller.componentUpdate.UpdateCanvas;
import js.html.CanvasElement;
import com.mun.model.component.Component;
import com.mun.type.HitObject;
import com.mun.type.WorldPoint;
import com.mun.model.component.CircuitDiagramI;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.model.component.Endpoint;
import com.mun.model.enumeration.KEY;
import com.mun.model.enumeration.K_STATE;
import com.mun.model.component.Link;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.enumeration.M_STATE;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.enumeration.MODE;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.type.Coordinate;
import js.html.MouseEvent;
import com.mun.model.enumeration.C_STATE;
class ControllerCanvasContext {
    var circuitDiagram:CircuitDiagramI;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var updateCanvas:UpdateCanvas;
    var keyState:KeyState;
    var sideBar:SideBar;
    var updateToolBar:UpdateToolBar;

    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;
    var lastClickArray:LinkAndComponentAndEndpointAndPortArray;
    var hitListWorldPoint:WorldPoint;

    var mouseMoveWorldCoordiante:Coordinate;
    var mouseDownWorldCoordinate:Coordinate;

    var lastState:C_STATE;
    var controllerState:C_STATE;
    var mouseState:M_STATE;

    var hightLightLink:Link;
    var canvas:CanvasElement;

    public function new(circuitDiagram:CircuitDiagramI, updateCircuitDiagram:UpdateCircuitDiagram, sideBar:SideBar, upateToolBar:UpdateToolBar, canvas:CanvasElement, updateCanvas:UpdateCanvas) {
        this.circuitDiagram = circuitDiagram;
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.sideBar = sideBar;
        this.updateToolBar = upateToolBar;
        this.canvas = canvas;
        this.updateCanvas = updateCanvas;

        controllerState = C_STATE.IDLE;
        lastState = C_STATE.IDLE;

        mouseState = M_STATE.IDLE;

        keyState = new KeyState();
        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
        lastClickArray = new LinkAndComponentAndEndpointAndPortArray();

        //add mouse  listener
        this.canvas.addEventListener("mousedown", doMouseDown,false);
        this.canvas.addEventListener("mousemove", doMouseMove,false);
        this.canvas.addEventListener("mouseup", doMouseUp,false);
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
        mouseDownWorldCoordinate = updateCanvas.getTransform().pointInvert(mouseDownLocation);

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
        mouseMoveWorldCoordiante = updateCanvas.getTransform().pointInvert(mouseMoveLocation);

        if(controllerState == C_STATE.MOVE){

            var moveWorldPointArray:Array<WorldPoint> = circuitDiagram.findWorldPoint(mouseMoveWorldCoordiante, POINT_MODE.PATH);

            var moveToOtherCircuitDiagram:Bool = true;
            for(i in moveWorldPointArray){
                if(i.get_circuitDiagram() == hitListWorldPoint.get_circuitDiagram()){
                    moveToOtherCircuitDiagram = false;
                    mouseMoveWorldCoordiante = i.get_coordinate();
                    break;
                }
            }

            //if move out of the selected circuit diagram. Freeze the move
            if(!moveToOtherCircuitDiagram){
                mouseMoveResultProcess();
                mouseDownWorldCoordinate = mouseMoveWorldCoordiante;
            }else{
                mouseMoveWorldCoordiante = mouseDownWorldCoordinate;
            }
        }else{//for create component
            mouseMoveResultProcess();
            mouseDownWorldCoordinate = mouseMoveWorldCoordiante;
        }

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
        }else if(controllerState == C_STATE.PASTE){
            lastState = controllerState;
            controllerState = C_STATE.MOVE;
            checkState();

            controllerState = C_STATE.PASTE;
        }
    }

    function checkHitList(){
        /**
        * Priority:
        * Port > Endpoint > Component = Link
        * */
        var hitObjectArray:Array<HitObject> = circuitDiagram.findHitList(mouseDownWorldCoordinate, MODE.EXCLUDE_PARENTS);
        //make sure all of the selected objects in the same circuit diagram, it should be the deepest circuit diagram
        hitListWorldPoint = circuitDiagram.findWorldPoint(mouseDownWorldCoordinate, POINT_MODE.ONE)[0];

        mouseDownWorldCoordinate = hitListWorldPoint.get_coordinate();

        //caculate how many component || link || port || endpoint has been hitted
        var componentCounter:Int = 0;
        var linkCounter:Int = 0;
        var portCounter:Int = 0;
        var endpointCounter:Int = 0;
        for(i in hitObjectArray){
            if(i.get_component() != null){
                componentCounter++;
            }else if(i.get_link() != null){
                linkCounter++;
            }else if(i.get_port() != null){
                portCounter++;
            }else if(i.get_endpoint != null){
                endpointCounter++;
            }
        }
        if(portCounter != 0 && endpointCounter == 0){
            //only port slected
            controllerState = C_STATE.CREATE_LINK;
            checkState();
        }else if(endpointCounter != 0 && portCounter != 0){//if this point on one endpoint and one port
            var endpoint:Endpoint = null;
            for(i in hitObjectArray){
                if(i.get_endpoint() != null){
                    endpoint = i.get_endpoint();
                }
            }

            if(updateCircuitDiagram.findLinkThroughEndpoint(endpoint) == hightLightLink){
                var object:Object = new Object();
                object.set_endPoint(endpoint);
                if(updateCircuitDiagram.findObjectInWhichCircuitDiagram(object) == hitListWorldPoint.get_circuitDiagram()){
                    linkAndComponentAndEndpointAndPortArray.addEndpoint(endpoint);
                }
            }else{
                controllerState = C_STATE.CREATE_LINK;
                checkState();
            }
        }else if(endpointCounter != 0 && portCounter == 0){//endpoint selected
            //only one endpoint can be selected
            var endpoint:Endpoint = null;
            for(i in hitObjectArray){
                if(i.get_endpoint() != null){
                    endpoint = i.get_endpoint();
                }
            }
            var object:Object = new Object();
            object.set_endPoint(endpoint);
            if(updateCircuitDiagram.findObjectInWhichCircuitDiagram(object) == hitListWorldPoint.get_circuitDiagram()){
                linkAndComponentAndEndpointAndPortArray.addEndpoint(endpoint);
            }
        }else if(componentCounter != 0){//component selected
            var component:Component = null;
            for(i in hitObjectArray){
                if(i.get_component() != null){
                    component = i.get_component();
                }
            }
            var object:Object = new Object();
            object.set_component(component);
            if(updateCircuitDiagram.findObjectInWhichCircuitDiagram(object) == hitListWorldPoint.get_circuitDiagram()){
                linkAndComponentAndEndpointAndPortArray.addComponent(component);
            }
        }else if(linkCounter != 0){//link selected
            var link:Link = null;
            for(i in hitObjectArray){
                if(i.get_link() != null){
                    link = i.get_link();
                }
            }
            hightLightLink = link;
            var object:Object = new Object();
            object.set_link(link);
            if(updateCircuitDiagram.findObjectInWhichCircuitDiagram(object) == hitListWorldPoint.get_circuitDiagram()){
                linkAndComponentAndEndpointAndPortArray.addLink(link);
            }
        }else if(componentCounter == 0 && linkCounter == 0 && portCounter == 0 && endpointCounter == 0){
            controllerState = C_STATE.CREATE_LINK;
            checkState();
        }

        updateCircuitDiagram.hightLightObject(linkAndComponentAndEndpointAndPortArray);

        //update tool bar
        toolBarUpdate();
    }

    function checkState(){
        switch(controllerState){
            case C_STATE.IDLE : {
                lastClickArray.setArray(linkAndComponentAndEndpointAndPortArray);
                if(!(keyState.get_key() == KEY.ALT_KEY && keyState.get_keyState() == K_STATE.KEY_DOWN)){
                    linkAndComponentAndEndpointAndPortArray.clean();
                }

                //check is any link is not enough long: link at least need have 10 pixel long
                for(i in circuitDiagram.get_linkIterator()){
                    var linkLength:Float = Math.sqrt(Math.pow(Math.abs(i.get_rightEndpoint().get_xPosition() - i.get_leftEndpoint().get_xPosition()), 2) + Math.pow(Math.abs(i.get_rightEndpoint().get_yPosition() - i.get_leftEndpoint().get_yPosition()), 2));

                    if(linkLength < 10){
                        circuitDiagram.get_commandManager().undo();
                        circuitDiagram.get_commandManager().popRedoStack();
                    }
                }
            };
            case C_STATE.CREATE_COMPONENT : {
                updateCircuitDiagram.createComponentByCommand(sideBar.getComponent());
                linkAndComponentAndEndpointAndPortArray.addComponent(sideBar.getComponent());
            };
            case C_STATE.CREATE_LINK : {
                var link:Link = updateCircuitDiagram.addLink(mouseDownWorldCoordinate,mouseDownWorldCoordinate, hitListWorldPoint.get_circuitDiagram());
                linkAndComponentAndEndpointAndPortArray.addEndpoint(link.get_rightEndpoint());
                hightLightLink = link;
            };
            case C_STATE.MOVE : {
                if(!linkAndComponentAndEndpointAndPortArray.isEmpty()){
                    if(lastState == C_STATE.CREATE_COMPONENT){
                        updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointAndPortArray, mouseMoveWorldCoordiante, mouseMoveWorldCoordiante, true);
                    }else if(lastState == C_STATE.PASTE){
                        updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointAndPortArray, mouseMoveWorldCoordiante, mouseDownWorldCoordinate, false);
                    }else{
                        updateCircuitDiagram.moveSelectedObjects(linkAndComponentAndEndpointAndPortArray, mouseMoveWorldCoordiante, mouseDownWorldCoordinate, false);
                    }
                }
            };
            case C_STATE.PASTE : {
                linkAndComponentAndEndpointAndPortArray.clean();
                linkAndComponentAndEndpointAndPortArray.setArray(updateCircuitDiagram.paste(mouseMoveWorldCoordiante));
                updateCircuitDiagram.get_commandManager().recordFlagSetTrue();
            };
            case C_STATE.MULTI_SELECTION : {
                linkAndComponentAndEndpointAndPortArray.setArray(lastClickArray);
                checkHitList();
            };
            case C_STATE.SINGLE_SELECTION : {
                linkAndComponentAndEndpointAndPortArray.clean();
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
