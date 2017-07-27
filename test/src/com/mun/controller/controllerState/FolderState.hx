package com.mun.controller.controllerState;

import js.jquery.JQuery;
import js.Browser;
import js.html.DOMElement;
import com.mun.controller.componentUpdate.UpdateCanvas;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Folder;
import com.mun.model.component.FolderI;
import com.mun.model.enumeration.F_STATE;
import com.mun.global.Constant.*;
class FolderState {
    var currentState:F_STATE;

    var folder:FolderI;
    var circuitDiagram:CircuitDiagramI;
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var updateToolBar:UpdateToolBar;
    var updateCanvas:UpdateCanvas;
    var sideBar:SideBar;
    var controllerCanvasContext:ControllerCanvasContext;

    var updateCircuitDiagramMap:Map<CircuitDiagramI, UpdateCircuitDiagram>;
    var updateToolBarMap:Map<CircuitDiagramI, UpdateToolBar>;
    var updateCanvasMap:Map<CircuitDiagramI, UpdateCanvas>;
    var sideBarMap:Map<CircuitDiagramI, SideBar>;
    var controllerCanvasContextMap:Map<CircuitDiagramI, ControllerCanvasContext>;

    var previouseCircuitDiagramName:Array<String>;
    var nextCircuitDiagramName:Array<String>;

    public function new() {
        updateCircuitDiagramMap = new Map<CircuitDiagramI, UpdateCircuitDiagram>();
        updateToolBarMap = new Map<CircuitDiagramI, UpdateToolBar>();
        updateCanvasMap = new Map<CircuitDiagramI, UpdateCanvas>();
        sideBarMap = new Map<CircuitDiagramI, SideBar>();
        controllerCanvasContextMap = new Map<CircuitDiagramI, ControllerCanvasContext>();

        previouseCircuitDiagramName = new Array<String>();
        nextCircuitDiagramName = new Array<String>();

        folder = new Folder();
        currentState = F_STATE.IDLE;
        checkState();

        Browser.document.getElementById("createNewCircuitDiagram").onclick = function(){
            currentState = F_STATE.CREATE;
            checkState();
        };

        Browser.document.getElementById("previouseCD").onclick = function(){
            currentState = F_STATE.PREVIOUS;
            checkState();
        };

        Browser.document.getElementById("nextCD").onclick = function(){
            currentState = F_STATE.NEXT;
            checkState();
        };
    }

    function checkState(){
        switch(currentState){
            case F_STATE.IDLE:{
                createATotallyNewCircuitDiagram();
                currentState = F_STATE.CURRENT;

                checkState();
            };
            case F_STATE.CURRENT : {
                //wait for instructrion
                Browser.document.getElementById("nameofcd").innerText = circuitDiagram.get_name();

                if(previouseCircuitDiagramName.length == 0){
                    setButtonDisability(Browser.document.getElementById("previouseCD"), true);
                }else{
                    setButtonDisability(Browser.document.getElementById("previouseCD"), false);
                }

                if(nextCircuitDiagramName.length == 0){
                    setButtonDisability(Browser.document.getElementById("nextCD"), true);
                }else{
                    setButtonDisability(Browser.document.getElementById("nextCD"), false);
                }
            };
            case F_STATE.CREATE : {//create a new circuit diagram
                previouseCircuitDiagramName .push(circuitDiagram.get_name());
                createATotallyNewCircuitDiagram();
                //redraw the canvas
                updateCircuitDiagram.redrawCanvas();

                currentState = F_STATE.CURRENT;

                checkState();
            };
            case F_STATE.NEXT :{
                if(nextCircuitDiagramName.length != 0){
                    previouseCircuitDiagramName.push(circuitDiagram.get_name());
                    setToCurrentCircuitDiagram(nextCircuitDiagramName.pop());
                    //redraw the canvas
                    updateCircuitDiagram.redrawCanvas();
                }
                currentState = F_STATE.CURRENT;

                checkState();
            };
            case F_STATE.PREVIOUS : {
                //go back to the previouse circuit diagram
                if(previouseCircuitDiagramName.length != 0){
                    nextCircuitDiagramName.push(circuitDiagram.get_name());
                    setToCurrentCircuitDiagram(previouseCircuitDiagramName.pop());
                    //redraw the canvas
                    updateCircuitDiagram.redrawCanvas();
                }

                currentState = F_STATE.CURRENT;

                checkState();
            };
            default : {
                //do nothing.
            }
        }
    }

    function setToCurrentCircuitDiagram(name:String){
        circuitDiagram = folder.findCircuitDiagram(name);
        updateCircuitDiagram = updateCircuitDiagramMap[circuitDiagram];
        updateToolBar = updateToolBarMap[circuitDiagram];
        updateCanvas = updateCanvasMap[circuitDiagram];
        sideBar = sideBarMap[circuitDiagram];
        controllerCanvasContext = controllerCanvasContextMap[circuitDiagram];
    }

    function createATotallyNewCircuitDiagram(){
        circuitDiagram = folder.createNewCircuitDiagram();

        updateCircuitDiagram = new UpdateCircuitDiagram(circuitDiagram);
        circuitDiagram.set_commandManager(updateCircuitDiagram.get_commandManager());

        updateToolBar = new UpdateToolBar(updateCircuitDiagram);
        updateCircuitDiagram.setUpdateToolBar(updateToolBar);

        updateCanvas = new UpdateCanvas(CANVAS, circuitDiagram, updateCircuitDiagram.get_transform());
        updateCircuitDiagram.setUpdateCanvas(updateCanvas);

        sideBar = new SideBar(updateCircuitDiagram);

        controllerCanvasContext = new ControllerCanvasContext(CANVAS, circuitDiagram, updateCircuitDiagram, sideBar, updateToolBar);
        sideBar.setControllerCanvasContext(controllerCanvasContext);

        pushToMap();
    }

    function pushToMap(){
        updateCircuitDiagramMap.set(circuitDiagram, updateCircuitDiagram);
        updateToolBarMap.set(circuitDiagram, updateToolBar);
        updateCanvasMap.set(circuitDiagram, updateCanvas);
        sideBarMap.set(circuitDiagram, sideBar);
        controllerCanvasContextMap.set(circuitDiagram, controllerCanvasContext);
    }

    function setButtonDisability(button:DOMElement,disable:Bool){
        if(disable){
            button.setAttribute("disabled", "disabled");
        }else{
            new JQuery(button).removeAttr("disabled");
        }
    }
}
