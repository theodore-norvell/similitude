package com.mun.controller.controllerState;

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

    var searchElement:DOMElement;
    var buttonGroupList:DOMElement;

    var gateNameArray:Array<String>;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram) {
        this.updateCircuitDiagram = updateCircuitDiagram;

        gateNameArray = new Array<String>();

        buttonGroupList = Browser.document.getElementById("buttonGroupList");
        initialButtonGroupList();

        bandingOnClick();
        pushGateName("AND");
        pushGateName("FLIPFLOP");
        pushGateName("INPUT");
        pushGateName("MUX");
        pushGateName("NAND");
        pushGateName("NOR");
        pushGateName("NOT");
        pushGateName("OR");
        pushGateName("OUTPUT");
        pushGateName("XOR");

        searchElement = Browser.document.getElementById("search");
        searchElement.onkeyup = search;

        Browser.document.getElementById("buttonList").onclick = buttonList;
        Browser.document.getElementById("fileList").onclick = fileList;

        buttonOrFileList = true;//initialization
    }

    function bandingOnClick(){
        if(Browser.document.getElementById("AND") != null){
            Browser.document.getElementById("AND").onmousedown = andOnClick;
        }
        if(Browser.document.getElementById("FLIPFLOP") != null){
            Browser.document.getElementById("FLIPFLOP").onmousedown = flipFlopOnClick;
        }
        if(Browser.document.getElementById("INPUT") != null){
            Browser.document.getElementById("INPUT").onmousedown = inputOnClick;
        }
        if(Browser.document.getElementById("MUX") != null){
            Browser.document.getElementById("MUX").onmousedown = muxOnClick;
        }
        if(Browser.document.getElementById("NAND") != null){
            Browser.document.getElementById("NAND").onmousedown = nandOnClick;
        }
        if(Browser.document.getElementById("NOR") != null){
            Browser.document.getElementById("NOR").onmousedown = norOnClick;
        }
        if(Browser.document.getElementById("NOT") != null){
            Browser.document.getElementById("NOT").onmousedown = notOnClick;
        }
        if(Browser.document.getElementById("OR") != null){
            Browser.document.getElementById("OR").onmousedown = orOnClick;
        }
        if(Browser.document.getElementById("OUTPUT") != null){
            Browser.document.getElementById("OUTPUT").onmousedown = outputOnClick;
        }
        if(Browser.document.getElementById("XOR") != null){
            Browser.document.getElementById("XOR").onmousedown = xorOnClick;
        }
    }

    function pushGateName(name:String){
        if(name.length != 0){
            gateNameArray.push(name);
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
                if(i.indexOf(value.toLowerCase()) != -1 || i.indexOf(value.toUpperCase()) != -1){
                    htmlString += "<button id=\"" + i + "\" type=\"button\" class=\"btn btn-default active\">"+ i + "</button>";
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
        buttonGroupList.innerHTML = "<button id=\"AND\" type=\"button\" class=\"btn btn-default active\">AND</button>
            <button id=\"OR\" type=\"button\" class=\"btn btn-default active\">OR</button>
            <button id=\"NOT\" type=\"button\" class=\"btn btn-default active\">NOT</button>
            <button id=\"NOR\" type=\"button\" class=\"btn btn-default active\">NOR</button>
            <button id=\"NAND\" type=\"button\" class=\"btn btn-default active\">NAND</button>
            <button id=\"XOR\" type=\"button\" class=\"btn btn-default active\">XOR</button>
            <button id=\"MUX\" type=\"button\" class=\"btn btn-default active\">MUX</button>
            <button id=\"FLIPFLOP\" type=\"button\" class=\"btn btn-default active\">FlipFlop</button>
            <button id=\"INPUT\" type=\"button\" class=\"btn btn-default active\">INPUT</button>
            <button id=\"OUTPUT\" type=\"button\" class=\"btn btn-default active\">OUTPUT</button>";
    }
}
