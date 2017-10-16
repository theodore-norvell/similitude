package com.mun.controller.command;

import com.mun.model.component.Component;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;

class ValueCommand implements Command{

    var component:Component;
    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;

    public function new(component:Component) {
        this.component=component;
        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray{


}

     public function redo():LinkAndComponentAndEndpointAndPortArray{
         execute();
         return linkAndComponentAndEndpointAndPortArray;
}

     public function execute():Void{


}

}
