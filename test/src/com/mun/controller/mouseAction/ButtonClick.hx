package com.mun.controller.mouseAction;

import com.mun.model.enumeration.C_STATE;
import com.mun.controller.controllerState.ControllerCanvasContext;
import com.mun.model.component.Component;
import js.Browser;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.enumeration.ORIENTATION;
class ButtonClick {
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var pixelRatio:Int;
    var component:Component;
    var controllerCanavasContext:ControllerCanvasContext;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram, pixelRatio:Int) {
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.pixelRatio = pixelRatio;

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
        Browser.document.getElementById("compoundComponent").onclick = compoundComponentOnClick;
    }

    public function setControllerCanvasContext(controllerCanvasContext:ControllerCanvasContext){
        this.controllerCanavasContext = controllerCanvasContext;
    }

    public function getComponent():Component{
        return component;
    }

    function andOnClick(){
        component = updateCircuitDiagram.createComponent("AND",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function flipFlopOnClick(){
        component = updateCircuitDiagram.createComponent("FlipFlop",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function inputOnClick(){
        component = updateCircuitDiagram.createComponent("Input",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function muxOnClick(){
        component = updateCircuitDiagram.createComponent("MUX",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function nandOnClick(){
        component = updateCircuitDiagram.createComponent("NAND",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function norOnClick(){
        component = updateCircuitDiagram.createComponent("NOR",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function notOnClick(){
        component = updateCircuitDiagram.createComponent("NOT",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function orOnClick(){
        component = updateCircuitDiagram.createComponent("OR",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function outputOnClick(){
        component = updateCircuitDiagram.createComponent("Output",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function xorOnClick(){
        component = updateCircuitDiagram.createComponent("XOR",250, 50, 40 * pixelRatio, 40 * pixelRatio, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }

    function compoundComponentOnClick(){
        //TODO
    }
}
