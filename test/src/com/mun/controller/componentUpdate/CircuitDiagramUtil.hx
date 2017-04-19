package com.mun.controller.componentUpdate;

import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.model.component.Port;
import com.mun.model.component.Endpoint;
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
        var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
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

    public function isOnPort(cooridnate:Coordinate):Object{
        var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
        for(i in 0...circuitDiagram.get_componentArray().length){
            for(j in 0...circuitDiagram.get_componentArray()[i].get_inportArray().length){
                if(isInCircle(cooridnate, circuitDiagram.get_componentArray()[i].get_inportArray()[j].get_xPosition(),
                circuitDiagram.get_componentArray()[i].get_inportArray()[j].get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.port = circuitDiagram.get_componentArray()[i].get_inportArray()[j];
                    for(k in 0...circuitDiagram.get_linkArray().length){
                        object.endPoint = isLinkOnPort(circuitDiagram.get_linkArray()[k],circuitDiagram.get_componentArray()[i].get_inportArray()[j]);
                        return object;
                    }
                }
            }
            for(j in 0...circuitDiagram.get_componentArray()[i].get_outportArray().length){
                if(isInCircle(cooridnate, circuitDiagram.get_componentArray()[i].get_outportArray()[j].get_xPosition(),
                circuitDiagram.get_componentArray()[i].get_outportArray()[j].get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.port = circuitDiagram.get_componentArray()[i].get_outportArray()[j];
                    for(k in 0...circuitDiagram.get_linkArray().length){
                        object.endPoint = isLinkOnPort(circuitDiagram.get_linkArray()[k],circuitDiagram.get_componentArray()[i].get_outportArray()[j]);
                        return object;
                    }
                }
            }
        }
        return object;
    }

    function isLinkOnPort(link:Link, port:Port):Endpoint{
        var endpoint:Endpoint = null;
        //if this port has a endpoint (left)
        if(isEndpointOnPort(link.get_leftEndpoint(), port)){
            endpoint = link.get_leftEndpoint();
        }
        //if this port has a endpoint (right)
        if(isEndpointOnPort(link.get_rightEndpoint(), port)){
            endpoint = link.get_rightEndpoint();
        }
        return endpoint;
    }

    function isEndpointOnPort(endpoint:Endpoint, port:Port):Bool{
        if(endpoint.get_xPosition() == port.get_xPosition() && endpoint.get_yPosition() == port.get_yPosition()){
            return true;
        }else{
            return false;
        }
    }
    public function isInCircle(cooridnate:Coordinate, orignalXPosition:Float, orignalYPosition:Float):Bool{
        //the radius is 3
        if(Math.abs(cooridnate.xPosition - orignalXPosition) <= 3 && Math.abs(cooridnate.yPosition - orignalYPosition) <= 3){
            return true;
        }else{
            return false;
        }
    }

    function isInScope(orignalXposition:Float, orignalYposition:Float, mouseXPosition:Float, mouseYposition:Float, heigh:Float, width:Float):Bool{
        if((mouseXPosition >= Math.abs(orignalXposition - width/2) && orignalXposition <= orignalXposition + width/2)&&(mouseYposition >= Math.abs(orignalYposition - heigh/2) && mouseYposition <= orignalYposition + heigh/2)){
            return true;
        }else{
            return false;
        }
    }
}
