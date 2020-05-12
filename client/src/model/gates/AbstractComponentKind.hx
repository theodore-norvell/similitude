package model.gates;

import assertions.Assert ;
import model.attribute.* ;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.component.Port ;
import model.component.StandardAttributes ;
import model.drawingInterface.DrawingAdapterI ;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import model.selectionModel.SelectionModel ;
import type.Coordinate;
import type.HitObject;
import type.WorldPoint;
import global.Constant.portSize ;
/**
* abstract class for gates
* @author wanhui
**/
class AbstractComponentKind  {

    var attributes = new AttributeList() ;

    private function new() {
        attributes.add( StandardAttributes.orientation ) ;
    }

    public function getAttributes() : Iterator< AttributeUntyped > {
        return attributes.iterator() ;
    }

    public function canUpdate<T : AttributeValue>( component : Component, attribute : Attribute<T>, value : T ) : Bool {
        return canUpdateUntyped( component, attribute, value ) ;
    }

    public function canUpdateUntyped( component : Component, attribute : AttributeUntyped, value : AttributeValue ) : Bool {
        Assert.assert( attribute.getType() == value.getType() ) ;
        return component.attributeValueList.has( attribute ) ;
    }

    public function update<T : AttributeValue>( component : Component, attribute : Attribute<T>, value : T ) : Void {
        updateUntyped( component, attribute, value ) ;
    }

    public function updateUntyped( component : Component, attribute : AttributeUntyped, value : AttributeValue ) : Void {
        Assert.assert( canUpdateUntyped( component, attribute, value ) ) ;
        component.attributeValueList.setUntyped( attribute, value ) ;
        updateHelper( component, attribute, value ) ;
        component.notifyObservers(component) ;
    }
    
    
    /* The job of the update helper is to ensure that any kind specific invariants
    * of the component are restored prior to notifying the observers of the component.
    */
    private function updateHelper( component : Component, attribute : AttributeUntyped, value : AttributeValue ) : Void {
        if( attribute == StandardAttributes.orientation ) updatePortPositions( component ) ;
    }

    public function createPorts( component : Component, addPort : Port -> Void ) : Void {
        //TODO
    }

    public function updatePortPositions( component : Component  ) : Void {
        //TODO
    }

    public function findHitList(component : Component, coordinate:Coordinate, mode:MODE, includeSelf : Bool )
    :Array<HitObject> {
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();

        if( includeSelf && isInComponent(component, coordinate) ){
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
    function isInComponent(component : Component, coordinate:Coordinate) : Bool {
        return isInScope(component.get_xPosition(), component.get_yPosition(),
                         coordinate.get_xPosition(), coordinate.get_yPosition(),
                         component.get_height(), component.get_width()) ;
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
        return  mouseXPosition >= orignalXposition - width/2 
             && mouseXPosition <= orignalXposition + width/2
             && mouseYposition >= orignalYposition - heigh/2
             && mouseYposition <= orignalYposition + heigh/2 ;
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
        return Math.abs(coordinate.get_xPosition() - orignalXPosition) <= portSize
            && Math.abs(coordinate.get_yPosition() - orignalYPosition) <= portSize ;
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
