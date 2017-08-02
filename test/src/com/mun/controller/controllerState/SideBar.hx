package com.mun.controller.controllerState;

import com.mun.model.component.CircuitDiagramI;
import js.jquery.JQuery;
import js.html.DOMElement;
import com.mun.model.enumeration.C_STATE;
import com.mun.controller.controllerState.ControllerCanvasContext;
import com.mun.model.component.Component;
import js.Browser;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.global.Constant.*;
class SideBar {
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var component:Component;
    var controllerCanavasContext:ControllerCanvasContext;
    var buttonOrFileList:Bool;//button = true;   file = false
    var circuitDiagram:CircuitDiagramI;

    var searchElement:DOMElement;
    var buttonGroupList:DOMElement;

    var gateNameArray:Array<String>;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram, circuitDiagram:CircuitDiagramI) {
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.circuitDiagram = circuitDiagram;

        gateNameArray = new Array<String>();

        buttonGroupList = Browser.document.getElementById(circuitDiagram.get_name() + "-buttonGroupList");

        gateNameArray.push("AND");
        gateNameArray.push("FLIPFLOP");
        gateNameArray.push("INPUT");
        gateNameArray.push("MUX");
        gateNameArray.push("NAND");
        gateNameArray.push("NOR");
        gateNameArray.push("NOT");
        gateNameArray.push("OR");
        gateNameArray.push("OUTPUT");
        gateNameArray.push("XOR");

        initialButtonGroupList();

        bandingOnClick();

        searchElement = Browser.document.getElementById(circuitDiagram.get_name() + "-search");
        searchElement.onkeyup = search;

        Browser.document.getElementById(circuitDiagram.get_name() + "-buttonList").onclick = buttonList;
        Browser.document.getElementById(circuitDiagram.get_name() + "-fileList").onclick = fileList;

        buttonOrFileList = true;//initialization
    }

    public function pushCompoundComponentToGateNameArray(name:String){
        gateNameArray.push(name);
    }

    public function removeCompoundComponentToGateNameArray(name:String){
        gateNameArray.remove(name);
    }

    function bandingOnClick(){
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-AND") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-AND").onmousedown = andOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-FLIPFLOP") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-FLIPFLOP").onmousedown = flipFlopOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-INPUT") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-INPUT").onmousedown = inputOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-MUX") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-MUX").onmousedown = muxOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-NAND") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-NAND").onmousedown = nandOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-NOR") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-NOR").onmousedown = norOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-NOT") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-NOT").onmousedown = notOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-OR") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-OR").onmousedown = orOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-OUTPUT") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-OUTPUT").onmousedown = outputOnClick;
        }
        if(Browser.document.getElementById(circuitDiagram.get_name() + "-XOR") != null){
            Browser.document.getElementById(circuitDiagram.get_name() + "-XOR").onmousedown = xorOnClick;
        }
    }

    public function setControllerCanvasContext(controllerCanvasContext:ControllerCanvasContext){
        this.controllerCanavasContext = controllerCanvasContext;
    }

    public function getComponent():Component{
        return component;
    }

    function andOnClick(){
        component = updateCircuitDiagram.createComponent("AND",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function flipFlopOnClick(){
        component = updateCircuitDiagram.createComponent("FlipFlop",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function inputOnClick(){
        component = updateCircuitDiagram.createComponent("Input",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function muxOnClick(){
        component = updateCircuitDiagram.createComponent("MUX",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function nandOnClick(){
        component = updateCircuitDiagram.createComponent("NAND",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function norOnClick(){
        component = updateCircuitDiagram.createComponent("NOR",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function notOnClick(){
        component = updateCircuitDiagram.createComponent("NOT",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function orOnClick(){
        component = updateCircuitDiagram.createComponent("OR",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function outputOnClick(){
        component = updateCircuitDiagram.createComponent("Output",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }
    function xorOnClick(){
        component = updateCircuitDiagram.createComponent("XOR",250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
    }

    function compoundComponentOnClick(){
        //TODO
    }

    function search(){
        var value:String = new JQuery(searchElement).val();
        if(value.length != 0){
            var htmlString:String = "";
            for(i in gateNameArray){
                if(i.indexOf(value.toLowerCase()) != -1 || i.indexOf(value.toUpperCase()) != -1 || i == value){
                    htmlString += "<button id=\""+circuitDiagram.get_name() + "-" + i + "\" type=\"button\" class=\"btn btn-default active\">"+ i + "</button>";
                }
            }
            buttonGroupList.innerHTML = htmlString;
            bandingOnClick();
        }else{
            initialButtonGroupList();
        }
    }

    function buttonList(){
        buttonOrFileList = true;
    }

    function fileList(){
        buttonOrFileList = false;
    }

    function initialButtonGroupList(){
        buttonGroupList.innerHTML = "<button id=\""+circuitDiagram.get_name()+"-AND\" type=\"button\" class=\"btn btn-default active\">AND</button>
            <button id=\""+circuitDiagram.get_name()+"-OR\" type=\"button\" class=\"btn btn-default active\">OR</button>
            <button id=\""+circuitDiagram.get_name()+"-NOT\" type=\"button\" class=\"btn btn-default active\">NOT</button>
            <button id=\""+circuitDiagram.get_name()+"-NOR\" type=\"button\" class=\"btn btn-default active\">NOR</button>
            <button id=\""+circuitDiagram.get_name()+"-NAND\" type=\"button\" class=\"btn btn-default active\">NAND</button>
            <button id=\""+circuitDiagram.get_name()+"-XOR\" type=\"button\" class=\"btn btn-default active\">XOR</button>
            <button id=\""+circuitDiagram.get_name()+"-MUX\" type=\"button\" class=\"btn btn-default active\">MUX</button>
            <button id=\""+circuitDiagram.get_name()+"-FLIPFLOP\" type=\"button\" class=\"btn btn-default active\">FlipFlop</button>
            <button id=\""+circuitDiagram.get_name()+"-INPUT\" type=\"button\" class=\"btn btn-default active\">INPUT</button>
            <button id=\""+circuitDiagram.get_name()+"-OUTPUT\" type=\"button\" class=\"btn btn-default active\">OUTPUT</button>";
    }

    function appendButtonGroupList(name){
        new JQuery(buttonGroupList).append("<button id=\""+name+"-cc\" type=\"button\" class=\"btn btn-default active\">AND</button>");
    }
}
