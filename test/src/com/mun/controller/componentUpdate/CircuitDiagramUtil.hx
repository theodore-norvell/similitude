package com.mun.controller.componentUpdate;

import com.mun.model.component.Component;
import com.mun.model.component.Link;
import com.mun.model.component.Port;
import com.mun.model.component.Endpoint;
import com.mun.type.Type.Coordinate;
import com.mun.model.component.CircuitDiagramI;
import com.mun.type.Type.Object;
/**
* utility for processing the update from canvas
**/
class CircuitDiagramUtil {
    var circuitDiagram:CircuitDiagramI;

    public function new(circuitDiagram:CircuitDiagramI) {
        this.circuitDiagram = circuitDiagram;
    }

    /**
    * verify this coordinate in component or not
    * @param coordinate
    * @return if the coordinate in a component then return the component
    *           or  return null;
    **/
    public function isInComponent(coordinate:Coordinate):Component{
        var component:Component = null;
        for(i in circuitDiagram.get_componentIterator()){
            if(isInScope(i.get_xPosition(),
                            i.get_yPosition(),
                            coordinate.xPosition, coordinate.yPosition,
                            i.get_height(),
                            i.get_width()) == true){
                return i;
            }
        }
        return component;
    }

    /**
    * verify this coordinate on link or not
    * @param coordinate
    * @return if the coordinate on the link then return the link
    *           or  return null;
    **/
    public function isOnLink(coordinate:Coordinate):Link{
        for(i in circuitDiagram.get_linkIterator()){
            var leftEndpoint:Endpoint = i.get_leftEndpoint();
            var rightEndpoint:Endpoint = i.get_rightEndpoint();
            if(pointToLine(leftEndpoint.get_xPosition(), leftEndpoint.get_yPosition(),
                            rightEndpoint.get_xPosition(), rightEndpoint.get_yPosition(),
                            coordinate.xPosition, coordinate.yPosition) <= 3){
                //if the distance between the point to line less equal to 3, that means the line should be selected
                //only process the first link met

                //the mouse location should be a little away from the endpoint
                //because in case of it confuse about select endpoint or link
                var theDistanaceToLeftEndpoint = Math.sqrt(
                    Math.pow(Math.abs(coordinate.xPosition - i.get_leftEndpoint().get_xPosition()), 2) +
                    Math.pow(Math.abs(coordinate.yPosition - i.get_leftEndpoint().get_yPosition()), 2)
                );

                var theDistanceToRightEndpoint = Math.sqrt(
                    Math.pow(Math.abs(coordinate.xPosition - i.get_rightEndpoint().get_xPosition()), 2) +
                    Math.pow(Math.abs(coordinate.yPosition - i.get_rightEndpoint().get_yPosition()), 2)
                );
                if(theDistanaceToLeftEndpoint >= theDistanceToRightEndpoint){
                    if(theDistanceToRightEndpoint >= 5){
                        return i;
                    }
                }else{
                    if(theDistanaceToLeftEndpoint >= 5){
                        return i;
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

    /**
    * verify this coordinate on endpoint or not
    * @param coordinate
    * @return if the coordinate on the endpoint then return the endpoint
    *           or  return null;
    **/
    public function pointOnEndpoint(coordinate:Coordinate):Array<Endpoint>{
        var endpointArray:Array<Endpoint> = new Array<Endpoint>();
        for(i in circuitDiagram.get_linkIterator()){
            if(pointsDistance(i.get_leftEndpoint().get_xPosition(),
                            i.get_leftEndpoint().get_yPosition(),
                            coordinate.xPosition, coordinate.yPosition) <= 4){
                endpointArray.push(i.get_leftEndpoint());
            }

            if(pointsDistance(i.get_rightEndpoint().get_xPosition(),
                                i.get_rightEndpoint().get_yPosition(),
                                coordinate.xPosition, coordinate.yPosition) <= 4){
                endpointArray.push(i.get_rightEndpoint());
            }
        }
        return endpointArray;
    }

    /**
    * verify this coordinate on port or not
    * @param coordinate
    * @return if the coordinate on the port then return the port
    *           or  return null;
    **/
    public function isOnPort(cooridnate:Coordinate):Object{
        var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
        for(i in circuitDiagram.get_componentIterator()){
            for(j in i.get_inportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.port = j;
                    for(k in circuitDiagram.get_linkIterator()){
                        object.endPoint = isLinkOnPort(k,j);
                        return object;
                    }
                }
            }
            for(j in i.get_outportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.port = j;
                    for(k in circuitDiagram.get_linkIterator()){
                        object.endPoint = isLinkOnPort(k,j);
                        return object;
                    }
                }
            }
        }
        return object;
    }

    /**
    * verify the link on the port or not
     * @param link
     * @param port
     * @return endpoint   if one of the endpoint on the port, then return this endpoint
     *                          or return null
    **/
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

    /**
    * verify the endpoint on the port or not
     * @param endpoint
     * @param port
     * @return Bool   if the endpoint on the port, return true; otherwise, return false;
    **/
    function isEndpointOnPort(endpoint:Endpoint, port:Port):Bool{
        if(endpoint.get_xPosition() == port.get_xPosition() && endpoint.get_yPosition() == port.get_yPosition()){
            return true;
        }else{
            return false;
        }
    }

    /**
    * verify a point is in a circuit or not
     * @param coordinate     the point need to be verified
     * @param orignalXPosition   the circuit x position
     * @param orignalYPosition   the circuit y position
     * @return if in the circle, return true; otherwise, return false;
    **/
    public function isInCircle(coordinate:Coordinate, orignalXPosition:Float, orignalYPosition:Float):Bool{
        //the radius is 3
        if(Math.abs(coordinate.xPosition - orignalXPosition) <= 4 && Math.abs(coordinate.yPosition - orignalYPosition) <= 4){
            return true;
        }else{
            return false;
        }
    }

    /**
    * verify a mouse position is in a scope or not
     * @param orignalXposition   xposition of the component
     * @param orignalYposition   yposition of the component
     * @param mouseXPosition
     * @param mouseYposition
     * @param heigh
     * @param width
     * @reutrn if in the scope, return true; otherwise, return false;
    **/
    function isInScope(orignalXposition:Float, orignalYposition:Float, mouseXPosition:Float, mouseYposition:Float, heigh:Float, width:Float):Bool{
        if((mouseXPosition >= Math.abs(orignalXposition - width/2) && orignalXposition <= orignalXposition + width/2)&&(mouseYposition >= Math.abs(orignalYposition - heigh/2) && mouseYposition <= orignalYposition + heigh/2)){
            return true;
        }else{
            return false;
        }
    }
}
