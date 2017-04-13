package com.mun.controller.componentUpdate;

import com.mun.type.Type.Coordinate;
import com.mun.model.component.CircuitDiagram;
import com.mun.type.Type.Object;

class CircuitDiagramUtil {
    var circuitDiagram:CircuitDiagram;

    public function new(circuitDiagram:CircuitDiagram) {
        this.circuitDiagram = circuitDiagram;
    }

    public function isInComponent(cooridnate:Coordinate):Object{
        var i = circuitDiagram.get_componentArray().length - 1;
        var object:Object = {"link":null,"component":null,"endPoint":null};
        while(i >= 0){
            if(isInScope(circuitDiagram.get_componentArray()[i].get_xPosition(),
                circuitDiagram.get_componentArray()[i].get_yPosition(),
                cooridnate.xPosition, cooridnate.yPosition,
                circuitDiagram.get_componentArray()[i].get_height(),
                circuitDiagram.get_componentArray()[i].get_width()) == true){
                object.component= circuitDiagram.get_componentArray()[i];
                return object;
            }
            i--;
        }
        return object;
    }

    function isInScope(orignalXposition:Float, orignalYposition:Float, mouseXPosition:Float, mouseYposition:Float, heigh:Float, width:Float):Bool{
        if((mouseXPosition >= orignalXposition - width/2 && orignalXposition <= orignalXposition + width/2)&&(mouseYposition >= orignalYposition - heigh/2 && mouseYposition <= orignalYposition + heigh/2)){
            return true;
        }else{
            return false;
        }
    }
}
