package com.mun.controller.componentUpdate;

import js.jquery.JQuery;
import com.mun.model.enumeration.ORIENTATION;
import js.html.DOMElement;
import js.Browser;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
/**
* update the tool bar
**/
class UpdateToolBar {
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray;
    var nameInput:DOMElement;
    var orientation:DOMElement;
    var orientation_div:DOMElement;
    var toolBar:DOMElement;
    var deleteButton:DOMElement;
    var component_name_div:DOMElement;
    var undo:DOMElement;
    var redo:DOMElement;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram) {
        linkAndComponentArray = new LinkAndComponentAndEndpointAndPortArray();

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
        Browser.document.getElementById("east").onclick = changeToEast;

        toolBar.onfocus = onfocus;
    }

    function onfocus(){
        updateCircuitDiagram.get_commandManager().recordFlagRest();
    }

    public function update(linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){

        linkAndComponentArrayReset();
        if(linkAndComponentArray.getComponentIteratorLength() != 0){
            for(i in linkAndComponentArray.get_componentIterator()){
                this.linkAndComponentArray.addComponent(i);
            }
        }

        if(linkAndComponentArray.getLinkIteratorLength() != 0){
            for(i in linkAndComponentArray.get_linkIterator()){
                this.linkAndComponentArray.addLink(i);
            }
        }

        //linkAndComponentArray may contains link and component, so when link and component both exists, then only show those things both have

        if(linkAndComponentArray.getComponentIteratorLength() != 0 && linkAndComponentArray.getLinkIteratorLength() == 0){
            visible();
            setOrientation();
            if(linkAndComponentArray.getComponentIteratorLength() == 1){
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

    function setOrientation(){
        if(linkAndComponentArray.getComponentIteratorLength() == 1){
            new JQuery(orientation).val(linkAndComponentArray.getComponentFromIndex(0).get_orientation()+ "");
        }else{
            new JQuery(orientation).val(ORIENTATION.UNKNOW + "");
        }

    }

    function setNameInput(){
        new JQuery(nameInput).val(linkAndComponentArray.getComponentFromIndex(0).get_name());
    }

    function changeToNorth(){
        if(linkAndComponentArray.getComponentIteratorLength() != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentIterator(),ORIENTATION.NORTH);
            setOrientation();
        }
    }
    function changeToSouth(){
        if(linkAndComponentArray.getComponentIteratorLength() != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentIterator(),ORIENTATION.SOUTH);
            setOrientation();
        }
    }
    function changeToWest(){
        if(linkAndComponentArray.getComponentIteratorLength() != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentIterator(),ORIENTATION.WEST);
            setOrientation();
        }
    }
    function changeToEast(){
        if(linkAndComponentArray.getComponentIteratorLength() != 0){
            updateCircuitDiagram.changeOrientation(linkAndComponentArray.get_componentIterator(),ORIENTATION.EAST);
            setOrientation();
        }
    }

    function inputChange(){
        if(linkAndComponentArray.getComponentIteratorLength() == 1){
            var temp:Dynamic = new JQuery(nameInput).val();
            updateCircuitDiagram.setComponentName(linkAndComponentArray.getComponentFromIndex(0),temp);
        }
    }

    function deleteObject(){
        if(linkAndComponentArray.getComponentIteratorLength() != 0 || linkAndComponentArray.getLinkIteratorLength() != 0){
            updateCircuitDiagram.deleteObject(linkAndComponentArray);
        }
    }

    function undoCommand(){
        updateCircuitDiagram.undo();
    }

    function redoCommand(){
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

    function linkAndComponentArrayReset(){
        linkAndComponentArray.clean();
    }

    public function disableAllEvent(){
        Browser.document.getElementById("delete").removeEventListener("click", deleteObject, false);
        Browser.document.getElementById("undo").removeEventListener("click", undoCommand, false);
        Browser.document.getElementById("redo").removeEventListener("click", redoCommand, false);
        Browser.document.getElementById("name_input").removeEventListener("keyup",inputChange,false);
        Browser.document.getElementById("north").removeEventListener("click", changeToNorth, false);
        Browser.document.getElementById("south").removeEventListener("click", changeToSouth, false);
        Browser.document.getElementById("west").removeEventListener("click", changeToWest, false);
        Browser.document.getElementById("east").removeEventListener("click", changeToEast, false);
    }

    public function enableAllEvent(){
        Browser.document.getElementById("delete").addEventListener("click", deleteObject, false);
        Browser.document.getElementById("undo").addEventListener("click", undoCommand, false);
        Browser.document.getElementById("redo").addEventListener("click", redoCommand, false);
        Browser.document.getElementById("name_input").addEventListener("keyup",inputChange,false);
        Browser.document.getElementById("north").addEventListener("click", changeToNorth, false);
        Browser.document.getElementById("south").addEventListener("click", changeToSouth, false);
        Browser.document.getElementById("west").addEventListener("click", changeToWest, false);
        Browser.document.getElementById("east").addEventListener("click", changeToEast, false);
        update(new LinkAndComponentAndEndpointAndPortArray());
    }
}
