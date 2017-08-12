package com.mun.controller.controllerState;

import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.FolderI;
import js.html.Event;
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
    var folder:FolderI;

    var searchElement:DOMElement;
    var buttonGroupList:DOMElement;

    var gateNameArray:Array<String>;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram, circuitDiagram:CircuitDiagramI,folder:FolderI) {
        this.updateCircuitDiagram = updateCircuitDiagram;
        this.circuitDiagram = circuitDiagram;
        this.folder = folder;

        gateNameArray = new Array<String>();

        buttonGroupList = Browser.document.getElementById(circuitDiagram.get_name() + "-buttonGroupList");

        gateNameArray.push("AND");
        gateNameArray.push("FlipFlop");
        gateNameArray.push("Input");
        gateNameArray.push("MUX");
        gateNameArray.push("NAND");
        gateNameArray.push("NOR");
        gateNameArray.push("NOT");
        gateNameArray.push("OR");
        gateNameArray.push("Output");
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
        if(gateNameArray.indexOf(name) ==-1){
            gateNameArray.push(name);
            resetSideBarButtons();
        }
    }

    public function removeCompoundComponentToGateNameArray(name:String){
        gateNameArray.remove(name);
        resetSideBarButtons();
    }

    public function isGateNameExist(name:String):Bool{
        if(gateNameArray.indexOf(name) != -1){
            return true;
        }else{
            return false;
        }
    }

    function bandingOnClick(){
        for(i in gateNameArray){
            if(i == "AND" ||  i == "OR" ||  i == "NOT" ||  i == "NOR" ||  i == "NAND" ||  i == "XOR" ||  i == "MUX" ||  i == "FlipFlop" ||  i == "Input" ||  i == "Output"){
                if(Browser.document.getElementById(circuitDiagram.get_name() + "-" + i) != null){
                    Browser.document.getElementById(circuitDiagram.get_name() + "-" + i).onmousedown = function(event:Event){
                        var id:String = untyped event.target.id;
                        id = id.substring(id.indexOf("-") + 1, id.length);
                        component = updateCircuitDiagram.createComponent(id,250, 50, 40 * PIXELRATIO, 40 * PIXELRATIO, ORIENTATION.EAST, 2);
                        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
                    };
                }
            }else{
                if(Browser.document.getElementById(circuitDiagram.get_name() + "-" + i) != null){
                    Browser.document.getElementById(circuitDiagram.get_name() + "-" + i).onmousedown = function(event:Event){
                        var id:String = untyped event.target.id;
                        id = id.substring(id.indexOf("-") + 1, id.length);
                        component = updateCircuitDiagram.createCompoundComponent(id,250, 50, 100 * PIXELRATIO, 100 * PIXELRATIO, ORIENTATION.EAST, 2, folder.findCircuitDiagram(id));
                        controllerCanavasContext.set_controllerState(C_STATE.CREATE_COMPONENT);
                    }
                }
            }
        }
    }

    public function getCircuitDiagram():CircuitDiagramI{
        return circuitDiagram;
    }

    public function setControllerCanvasContext(controllerCanvasContext:ControllerCanvasContext){
        this.controllerCanavasContext = controllerCanvasContext;
    }

    public function getComponent():Component{
        return component;
    }

    function compoundComponentOnClick(){
        //TODO
    }

    function resetSideBarButtons(){
        initialButtonGroupList();
        for(i in gateNameArray){
            if(i != "AND" &&  i != "OR" &&  i != "NOT" &&  i != "NOR"
                &&  i != "NAND" &&  i != "XOR" &&  i != "MUX" &&  i != "FlipFlop"
                &&  i != "Input" &&  i != "Output"){
                var circuitDiagramForCheck:CircuitDiagramI = folder.findCircuitDiagram(i);
                for(j in circuitDiagramForCheck.get_componentIterator()){
                    if(j.getNameOfTheComponentKind() == "CC" && j.get_componentKind().getInnerCircuitDiagram().get_name() == i){
                        continue;
                    }else{
                        appendButtonGroupList(i);
                    }
                }
            }
        }
        bandingOnClick();
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
            bandingOnClick();
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
            <button id=\""+circuitDiagram.get_name()+"-FlipFlop\" type=\"button\" class=\"btn btn-default active\">FlipFlop</button>
            <button id=\""+circuitDiagram.get_name()+"-Input\" type=\"button\" class=\"btn btn-default active\">INPUT</button>
            <button id=\""+circuitDiagram.get_name()+"-Output\" type=\"button\" class=\"btn btn-default active\">OUTPUT</button>";
    }

    function appendButtonGroupList(name){
        new JQuery(buttonGroupList).append("<button id=\""+circuitDiagram.get_name()+"-"+name+"\" type=\"button\" class=\"btn btn-default active\">"+name+"</button>");
    }
}
