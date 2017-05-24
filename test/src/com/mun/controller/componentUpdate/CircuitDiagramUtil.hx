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

    public function isInComponent(coordinate:Coordinate):Component{
        var component:Component = null;
        var i = circuitDiagram.get_componentArray().length - 1;
        while(i >= 0){
            if(isInScope(circuitDiagram.get_componentArray()[i].get_xPosition(),
                            circuitDiagram.get_componentArray()[i].get_yPosition(),
                            coordinate.xPosition, coordinate.yPosition,
                            circuitDiagram.get_componentArray()[i].get_height(),
                            circuitDiagram.get_componentArray()[i].get_width()) == true){
                return circuitDiagram.get_componentArray()[i];
            }
            i--;
        }
        return component;
    }

    public function isOnLink(coordinate:Coordinate):Link{
        for(i in 0...circuitDiagram.get_linkArray().length){
            var leftEndpoint:Endpoint = circuitDiagram.get_linkArray()[i].get_leftEndpoint();
            var rightEndpoint:Endpoint = circuitDiagram.get_linkArray()[i].get_rightEndpoint();
            if(pointToLine(leftEndpoint.get_xPosition(), leftEndpoint.get_yPosition(),
                            rightEndpoint.get_xPosition(), rightEndpoint.get_yPosition(),
                            coordinate.xPosition, coordinate.yPosition) <= 3){
                //if the distance between the point to line less equal to 3, that means the line should be selected
                //only process the first link met

                //the mouse location should be a little away from the endpoint
                //because in case of it confuse about select endpoint or link
                var theDistanaceToLeftEndpoint = Math.sqrt(
                    Math.pow(Math.abs(coordinate.xPosition - circuitDiagram.get_linkArray()[i].get_leftEndpoint().get_xPosition()), 2) +
                    Math.pow(Math.abs(coordinate.yPosition - circuitDiagram.get_linkArray()[i].get_leftEndpoint().get_yPosition()), 2)
                );

                var theDistanceToRightEndpoint = Math.sqrt(
                    Math.pow(Math.abs(coordinate.xPosition - circuitDiagram.get_linkArray()[i].get_rightEndpoint().get_xPosition()), 2) +
                    Math.pow(Math.abs(coordinate.yPosition - circuitDiagram.get_linkArray()[i].get_rightEndpoint().get_yPosition()), 2)
                );
                if(theDistanaceToLeftEndpoint >= theDistanceToRightEndpoint){
                    if(theDistanceToRightEndpoint >= 5){
                        return circuitDiagram.get_linkArray()[i];
                    }
                }else{
                    if(theDistanaceToLeftEndpoint >= 5){
                        return circuitDiagram.get_linkArray()[i];
                    }
                }

            }
        }

        return null;
    }

    //the distance of point (x0,y0) to line [(x1,y1),(x2,y2)]
    public function pointToLine(x1:Float, y1:Float, x2:Float, y2:Float, x0:Float, y0:Float):Float{
        var space:Float = 0;
        var a,b,c:Float;

        a = pointsDistance(x1, y1, x2, y2);//the length of the line

        b = pointsDistance(x1, y1, x0, y0);//the distance from point (x0,y0) to (x1,y1)

        c = pointsDistance(x2, y2, x0, y0);//the distance from point (x0,y0) to (x2,y2)

        if(c + b == a){//the point is on the link
            space = 0;
            return space;
        }

        if(a <= 0.00001){//it is not a line, it is a point
            space = b;
            return space;
        }

        if(c * c > a * a + b * b){//Form a rectangular triangle or obtuse angle (x1,y1)
            space = b;
            return space;
        }

        if(b * b >= a * a + c * c){//Form a rectangular triangle or obtuse angle (x2,y2)
            space = c;
            return space;
        }

        //composed of acute angle triangle, then get the height

        var p:Float = (a + b + c) / 2;//circumference of the triangle

        var s:Float = Math.sqrt(p * (p - a) * (p - b) * (p - c));//Helen formula

        space = 2 * s / a;//return distance from point to line (using triangular area formula get the height

        return space;
    }

    //calculate the distance between two points
    public function pointsDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float{
        var lineLength:Float = 0;
        lineLength = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
        return lineLength;
    }

    public function pointOnEndpoint(coordinate:Coordinate):Endpoint{
        for(i in 0...circuitDiagram.get_linkArray().length){
            if(pointsDistance(circuitDiagram.get_linkArray()[i].get_leftEndpoint().get_xPosition(),
                            circuitDiagram.get_linkArray()[i].get_leftEndpoint().get_yPosition(),
                            coordinate.xPosition, coordinate.yPosition) <= 3){
                return circuitDiagram.get_linkArray()[i].get_leftEndpoint();
            }

            if(pointsDistance(circuitDiagram.get_linkArray()[i].get_rightEndpoint().get_xPosition(),
                                circuitDiagram.get_linkArray()[i].get_rightEndpoint().get_yPosition(),
                                coordinate.xPosition, coordinate.yPosition) <= 3){
                return circuitDiagram.get_linkArray()[i].get_rightEndpoint();
            }
        }
        return null;
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
