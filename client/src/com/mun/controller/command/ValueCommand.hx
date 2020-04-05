package com.mun.controller.command;

import com.mun.model.gates.ComponentKind;
import com.mun.model.component.Component;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;

class ValueCommand implements Command{

    var component:Component;
    var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray;
    var delay:Int;
    var temp:Int;

    public function new(component:Component, d:Int) {
        this.component=component;
        delay=d;
        linkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
    }

    public function undo():LinkAndComponentAndEndpointAndPortArray{
        if(temp!=null){
            component.set_delay(delay);
        }
        return linkAndComponentAndEndpointAndPortArray;


}

     public function redo():LinkAndComponentAndEndpointAndPortArray{
         execute();
         return linkAndComponentAndEndpointAndPortArray;
}

     public function execute():Void{
         if(delay!=null){
             temp=component.set_delay(delay);
             linkAndComponentAndEndpointAndPortArray.addComponent(component);
         }



}

}
