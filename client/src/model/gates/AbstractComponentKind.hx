package model.gates;

import assertions.Assert ;
import model.attribute.Attribute ;
import model.attribute.OrientationAttr ;
import model.attribute.StringAttr ;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.component.Port ;
import model.drawingInterface.DrawingAdapterI ;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import model.selectionModel.SelectionModel ;
import type.Coordinate;
import type.HitObject;
import type.WorldPoint;
/**
* abstract class for gates
* @author wanhui
**/
class AbstractComponentKind  {
    
    private var attributes:Array<Attribute>=new Array<Attribute>();

    private function new() {
        attributes.push(new OrientationAttr());
        attributes.push(new StringAttr("name"));
    }

    public function getAttr():Array<Attribute> {
        return attributes ;
    }

    public function createPorts( component : Component ) : Void {
        //TODO
    }

    public function updatePortPositions( component : Component  ) : Void {
        //TODO
    }

    public function findHitList(component : Component, coordinate:Coordinate, mode:MODE)
    :Array<HitObject> {
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();

        var component:Component = isInComponent(component, coordinate);
        if(component != null){
            var hitObject:HitObject = new HitObject();
            hitObject.set_component(component);
            hitObjectArray.push(hitObject);
        }

        var port:Port = isOnPort(component, coordinate);
        if(port != null){
            var hitObject:HitObject = new HitObject();
            hitObject.set_port(port);
            hitObjectArray.push(hitObject);
        }

        return hitObjectArray;
    }

    /**
    * verify this coordinate in component or not
    * @param coordinate
    * @return if the coordinate in a component then return the component
    *           or  return null;
    **/
    function isInComponent(component : Component, coordinate:Coordinate):Component {
        if(isInScope(component.get_xPosition(), component.get_yPosition(), coordinate.get_xPosition(), coordinate.get_yPosition(), component.get_height(), component.get_width())){
            return component;
        }
        return null;
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
        if((mouseXPosition >= orignalXposition - width/2 && mouseXPosition <= orignalXposition + width/2)&&(mouseYposition >= orignalYposition - heigh/2 && mouseYposition <= orignalYposition + heigh/2)){
            return true;
        }else{
            return false;
        }
    }

    /**
    * verify this coordinate on port or not
    * @param coordinate
    * @return if the coordinate on the port then return the port
    *           or  return null;
    **/
    function isOnPort(component : Component, cooridnate:Coordinate):Port{
        var port:Port;

            for(port in component.get_ports()){
                if(isInCircle(cooridnate, port.get_xPosition(), port.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    return port;
                }
            }

        return null;
    }


    /**
    * verify a point is in a circle or not
     * @param coordinate     the point need to be verified
     * @param orignalXPosition   the circuit x position
     * @param orignalYPosition   the circuit y position
     * @return if in the circle, return true; otherwise, return false;
    **/
    function isInCircle(coordinate:Coordinate, orignalXPosition:Float, orignalYPosition:Float):Bool{
        var portRadius = 3 ;
        return Math.abs(coordinate.get_xPosition() - orignalXPosition) <= portRadius
            && Math.abs(coordinate.get_yPosition() - orignalYPosition) <= portRadius ;
    }

    /**
    * for all component kinds except compound component, find world point always return a empty list
    **/
    public function findWorldPoint(component : Component, worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        return new Array<WorldPoint>();
    }

    public function getInnerCircuitDiagram():CircuitDiagramI{
        Assert.assert(false) ;
        return null;//for most of the componentkind it has no circuit diagram inside, except compound component
    }
}
