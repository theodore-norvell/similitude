package com.mun.controller.componentUpdate;

import com.mun.model.enumeration.Orientation;
import com.mun.model.component.CircuitDiagram;
import com.mun.type.Type.Object;
import js.html.DOMElement;
import js.Browser;
class UpdateToolBar {
    var circuitDiagram:CircuitDiagram;
    var updateCanvas:UpdateCanvas;
    var object:Object;
    var nameInput:DOMElement;
    var orientation:DOMElement;
    var toolBar:DOMElement;
    var deleteButton:DOMElement;

    public function new(circuitDiagram:CircuitDiagram, updateCanvas:UpdateCanvas) {
        this.circuitDiagram = circuitDiagram;
        this.updateCanvas = updateCanvas;

        nameInput = Browser.document.getElementById("name_input");
        orientation = Browser.document.getElementById("orientation");
        toolBar = Browser.document.getElementById("toolbar_div");
        deleteButton = Browser.document.getElementById("delete");

        nameInput.addEventListener("keyup",inputChange,false);
        deleteButton.onclick = deleteObject;
        Browser.document.getElementById("north").onclick = changeToNorth;
        Browser.document.getElementById("south").onclick = changeToSouth;
        Browser.document.getElementById("west").onclick = changeToWest;
        Browser.document.getElementById("east").onclick = chageToEast;
    }

    public function update(object:Object){
        this.object = object;
        if(object.component != null){
            nameInput.setAttribute("value",object.component.get_name());
            orientation.setAttribute("value", object.component.get_orientation() + "");
            visible();
        }
    }

    public function changeToNorth(){
        if(object.component != null){
            object.component.set_orientation(Orientation.NORTH);
            object.component.updateMoveComponentPortPosition(object.component.get_xPosition(),object.component.get_yPosition());
            updateCanvas.update();
        }
    }
    public function changeToSouth(){
        if(object.component != null){
            object.component.set_orientation(Orientation.SOUTH);
            object.component.updateMoveComponentPortPosition(object.component.get_xPosition(),object.component.get_yPosition());

            updateCanvas.update();
        }
    }
    public function changeToWest(){
        if(object.component != null){
            object.component.set_orientation(Orientation.WEST);
            object.component.updateMoveComponentPortPosition(object.component.get_xPosition(),object.component.get_yPosition());
            updateCanvas.update();
        }
    }
    public function chageToEast(){
        if(object.component != null){
            object.component.set_orientation(Orientation.EAST);
            object.component.updateMoveComponentPortPosition(object.component.get_xPosition(),object.component.get_yPosition());
            updateCanvas.update();
        }
    }

    public function inputChange(){
        if(object.component != null){
            object.component.set_name(nameInput.getAttribute("value"));
        }
    }

    public function deleteObject(){
        if(object.component != null){
            circuitDiagram.deleteComponent(object.component);
        }

        if(object.link != null){
            circuitDiagram.deleteLink(object.link);
        }
        updateCanvas.update();
    }

    public function visible(){
        toolBar.style.visibility = "visible";
    }

    public function hidden(){
        toolBar.style.visibility = "hidden";
    }
}
