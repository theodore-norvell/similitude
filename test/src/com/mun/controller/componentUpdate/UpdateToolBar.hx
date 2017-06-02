package com.mun.controller.componentUpdate;

import js.jquery.JQuery;
import com.mun.model.enumeration.Orientation;
import com.mun.type.Type.Object;
import js.html.DOMElement;
import js.Browser;
/**
* update the tool bar
**/
class UpdateToolBar {
    var updateCircuitDiagram:UpdateCircuitDiagram;
    var object:Object;
    var nameInput:DOMElement;
    var orientation:DOMElement;
    var orientation_div:DOMElement;
    var toolBar:DOMElement;
    var deleteButton:DOMElement;
    var component_name_div:DOMElement;
    var undo:DOMElement;
    var redo:DOMElement;

    public function new(updateCircuitDiagram:UpdateCircuitDiagram) {
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
    }

    public function update(object:Object){
        this.object = object;
        if(object.component != null){
            visible();
            setAttribute();

        }

        if(object.link != null){
            visible();
            component_name_div.style.visibility = "hidden";
            orientation_div.style.visibility = "hidden";
        }
    }

    public function setAttribute(){
        new JQuery(nameInput).val(object.component.get_name());
        new JQuery(orientation).val(object.component.get_orientation() + "");
    }

    public function changeToNorth(){
        if(object.component != null){
            updateCircuitDiagram.changeOrientation(object.component,Orientation.NORTH);
            setAttribute();
        }
    }
    public function changeToSouth(){
        if(object.component != null){
            updateCircuitDiagram.changeOrientation(object.component,Orientation.SOUTH);
            setAttribute();
        }
    }
    public function changeToWest(){
        if(object.component != null){
            updateCircuitDiagram.changeOrientation(object.component,Orientation.WEST);
            setAttribute();
        }
    }
    public function chageToEast(){
        if(object.component != null){
            updateCircuitDiagram.changeOrientation(object.component,Orientation.EAST);
            setAttribute();
        }
    }

    public function inputChange(){

        if(object.component != null){
            var temp:Dynamic = new JQuery(nameInput).val();
            updateCircuitDiagram.setComponentName(object.component,temp);
        }
    }

    public function deleteObject(){
        if(object.component != null){
            updateCircuitDiagram.deleteComponent(object.component);
        }

        if(object.link != null){
            updateCircuitDiagram.deleteLink(object.link);
        }
        updateCircuitDiagram.redrawCanvas();
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
}
