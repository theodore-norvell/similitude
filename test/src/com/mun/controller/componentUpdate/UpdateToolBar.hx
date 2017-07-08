package com.mun.controller.componentUpdate;

import com.mun.model.component.Component;
import com.mun.model.component.Link;
import js.jquery.JQuery;
import com.mun.model.enumeration.Orientation;
import js.html.DOMElement;
import js.Browser;
import com.mun.type.LinkAndComponentArray;
/**
* update the tool bar
**/
class UpdateToolBar {
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var linkAndComponentArray:LinkAndComponentArray;
    var nameInput:DOMElement;
    var orientation:DOMElement;
    var orientation_div:DOMElement;
    var toolBar:DOMElement;
    var deleteButton:DOMElement;
    var component_name_div:DOMElement;
    var undo:DOMElement;
    var redo:DOMElement;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram) {
        linkAndComponentArray = new LinkAndComponentArray();

        this.updateCircuitDiagram = updateCircuitDiagram;

        nameInput = Browser.document.getElementById("name_input");
        orientation = Browser.document.getElementById("orientation");
        toolBar = Browser.document.getElementById("toolbar_div");
        deleteButton = Browser.document.getElementById("delete");
        orientation_div = Browser.document.getElementById("orientation_div");
        component_name_div = Browser.document.getElementById("component_name_div");
        undo = Browser.document.getElementById("undo");
        undo.style.visibility = "visible";
        redo = Browser.document.getElementById("redo");
        redo.style.visibility = "visible";

        nameInput.addEventListener("keyup",inputChange,false);
        deleteButton.onclick = deleteObject;
        undo.onclick = undoCommand;
        redo.onclick = redoCommand;
        Browser.document.getElementById("north").onclick = changeToNorth;
        Browser.document.getElementById("south").onclick = changeToSouth;
        Browser.document.getElementById("west").onclick = changeToWest;
        Browser.document.getElementById("east").onclick = chageToEast;

        toolBar.onfocus = onfocus;
    }

    public function onfocus(){
        updateCircuitDiagram.get_commandManager().recordFlagRest();
    }

    public function update(linkAndComponentArray:LinkAndComponentArray){

        linkAndComponentArrayReset();

        if(linkAndComponentArray.get_componentArray() != null){
            for(i in linkAndComponentArray.get_componentArray()){
                this.linkAndComponentArray.addComponent(i);
            }
        }

        if(linkAndComponentArray.get_linkArray() != null){
            for(i in linkAndComponentArray.get_linkArray()){
                this.linkAndComponentArray.addLink(i);
            }
        }

        //linkAndComponentArray may contains link and component, so when link and component both exists, then only show those things both have

        if(linkAndComponentArray.get_componentArray().length != 0 && (linkAndComponentArray.get_linkArray() == null || linkAndComponentArray.get_linkArray().length == 0)){
            visible();
            setOrientation();
            if(linkAndComponentArray.get_componentArray().length == 1){
                setNameInput();
            }else{
                component_name_div.style.visibility = "hidden";
            }
        }else{
            visible();
            component_name_div.style.visibility = "hidden";
            orientation_div.style.visibility = "hidden";
        }
    }

    public function setOrientation(){
        if(linkAndComponentArray.get_componentArray() != null && linkAndComponentArray.get_componentArray().length == 1){
            new JQuery(orientation).val(linkAndComponentArray.get_componentArray()[0].get_orientation() + "");
        }else{
            new JQuery(orientation).val(Orientation.UNKNOW + "");
        }

    }

    public function setNameInput(){
        new JQuery(nameInput).val(linkAndComponentArray.get_componentArray()[0].get_name());
    }

    public function changeToNorth(){
        if(linkAndComponentArray.get_componentArray().length != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentArray(),Orientation.NORTH);
            setOrientation();
        }
    }
    public function changeToSouth(){
        if(linkAndComponentArray.get_componentArray().length != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentArray(),Orientation.SOUTH);
            setOrientation();
        }
    }
    public function changeToWest(){
        if(linkAndComponentArray.get_componentArray().length != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentArray(),Orientation.WEST);
            setOrientation();
        }
    }
    public function chageToEast(){
        if(linkAndComponentArray.get_componentArray().length != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentArray(),Orientation.EAST);
            setOrientation();
        }
    }

    public function inputChange(){
        if(linkAndComponentArray.get_componentArray() != null && linkAndComponentArray.get_componentArray().length == 1){
            var temp:Dynamic = new JQuery(nameInput).val();
            updateCircuitDiagram.setComponentName(linkAndComponentArray.get_componentArray()[0],temp);
        }
    }

    public function deleteObject(){
        if(linkAndComponentArray.get_componentArray().length != 0 || linkAndComponentArray.get_linkArray().length != 0){
            updateCircuitDiagram.deleteObject(linkAndComponentArray);
        }
    }

    public function undoCommand(){
        updateCircuitDiagram.undo();
    }

    public function redoCommand(){
        updateCircuitDiagram.redo();
    }

    public function visible(){
        deleteButton.style.visibility = "visible";
        orientation_div.style.visibility = "visible";
        component_name_div.style.visibility = "visible";
    }

    public function hidden(){
        deleteButton.style.visibility = "hidden";
        orientation_div.style.visibility = "hidden";
        component_name_div.style.visibility = "hidden";
    }

    public function setUndoButtonDisability(disable:Bool){
        if(disable){
            undo.setAttribute("disabled", "disabled");
        }else{
            new JQuery(undo).removeAttr("disabled");
        }
    }

    public function setRedoButtonDisability(disable:Bool){
        if(disable){
            redo.setAttribute("disabled", "disabled");
        }else{
            new JQuery(redo).removeAttr("disabled");
        }
    }

    public function linkAndComponentArrayReset(){
        linkAndComponentArray.clean();
    }
}
