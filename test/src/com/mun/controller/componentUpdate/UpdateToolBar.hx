package com.mun.controller.componentUpdate;
import js.html.DOMElement;
import com.mun.model.component.Component;
import js.Browser;
class UpdateToolBar {
    var component:Component;
    var nameInput:DOMElement;
    var orientation:DOMElement;
    var toolBar:DOMElement;

    public function new() {
        nameInput = Browser.document.getElementById("name_input");
        orientation = Browser.document.getElementById("orientation");
        toolBar = Browser.document.getElementById("toolbar_div");

        nameInput.addEventListener("change",inputChange,false);
    }

    public function update(component:Component){
        this.component = component;
        nameInput.setAttribute("value",component.get_name());
        orientation.setAttribute("value", component.get_orientation() + "");
        visible();
    }

    public function inputChange(){
        trace(nameInput.getAttribute("value"));
    }

    public function visible(){
        toolBar.style.visibility = "visible";
    }

    public function hidden(){
        toolBar.style.visibility = "hidden";
    }
}
