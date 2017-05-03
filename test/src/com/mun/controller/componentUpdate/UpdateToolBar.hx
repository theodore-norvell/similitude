package com.mun.controller.componentUpdate;
import com.mun.type.Type.Object;
import js.Browser;
class UpdateToolBar {

    public function new() {

    }

    public function createUpdate(object:Object){
        trace(object.component.get_name());
        Browser.document.getElementById("name_input").setAttribute("value",object.component.get_name());
        Browser.document.getElementById("orientation").setAttribute("value", object.component.get_orientation() + "");
    }

}
