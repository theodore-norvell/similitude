package model.gates;

import type.HitObject;
import model.attribute.* ;
import model.component.CircuitDiagramI;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import type.Coordinate;
import type.WorldPoint;
import model.drawingInterface.DrawingAdapterI;
import model.component.Component;
import model.selectionModel.SelectionModel ;
import model.component.Port;
import model.enumeration.Orientation;
/**
* Component Kind
* @author wanhui
**/
interface ComponentKind {

    public function getname():String;

    /** create ports for each gate.
    *  Because box can identify the 4 corner of the component, so we can use a,b,c,d to identify the position of the component
    *  @param xPosition : x position
    *  @param yPosition : y position
    *  @param height : height
    *  @param width : width
    *  @param orientation : direction
    *  @param [Optional] inportNum : the number of inports in this gates, initial value is 2
    *  @return the array of the created ports
    **/

    public function getAttributes() : Iterator< Attribute<AttributeValue> > ;

    public function canUpdate<T : AttributeValue>( component : Component, attribute : Attribute<T>, value : T ) : Bool ;

    public function update<T : AttributeValue>( component : Component, attribute : Attribute<T>, value : T ) : Void ;
    public function createPorts( component : Component, addPort : Port -> Void ) : Void ;

    /**
     *  Update the positions of the ports of a component.
     * @param component 
     */
    public function updatePortPositions( component : Component  ) : Void ;

    /**
    * draw this componentkind
     * @param component
     * @param drawingAdapter
     * @param highlight Should this component be highlighted
     * @param selection The set of things that should be highlighted
    **/
    public function drawComponent( component : Component, drawingAdapter:DrawingAdapterI, hightLight:Bool, selection : SelectionModel ):Void;

    /**
    * find the hit list
    **/
    public function findHitList(component : Component, coordinate:Coordinate, mode:MODE):Array<HitObject>;

    /**
    * find world point
    **/
    public function findWorldPoint(component : Component, worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>;

    /**
    * this function just use for compound component
    * TODO Get rid of this.
    **/
    public function getInnerCircuitDiagram():CircuitDiagramI;
}
