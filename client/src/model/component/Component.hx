package model.component;

import model.attribute.* ;
import model.selectionModel.SelectionModel;
import model.observe.Observable;
import type.HitObject;
import model.enumeration.BOX;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import type.Coordinate;
import type.WorldPoint;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
import model.gates.ComponentKind;
import assertions.Assert;

/**
 * Component composite by gates and ports, in this class
 * will composite gates and ports into one entity.
 * @author wanhui
 *
 */

class Component extends CircuitElement {
    var xPosition:Float;//the x position of the component
    var yPosition:Float;//the y position of the component
    var height:Float;//height
    var width:Float;//width
    // TODO: make sequenceNumber an attribute.
    var sequenceNumber : Int ; // This should be -1 unless the component is an
                            // input or an output. In that case, it represents
                            // the component's position relative to other inputs
                            // and outputs.
    var componentKind:ComponentKind;//the actual gate in this component
    // The ports that belong to this component.
    var  ports : Array<Port> = new Array<Port>() ;
    // TODO Make boxType an attribute for the kinds where it makes sense.
    var boxType:BOX;

    @:allow( model.gates )
    var attributeValueList : AttributeValueList ;
    
    /**
    *   create component
     *   @param xPosition: x position
     *   @param yPosition: y position
     *   @param height: height of this component
     *   @param width: width of this component
     *   @param orientation: Orientation of this component
     *   @param componentkind: which componentkind belongs to
     *   @param inportNum: how many inports should be in this component, initial value should be depend on what kind of component it is
    **/
    public function new(circuitDiagram : CircuitDiagramI, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, componentKind:ComponentKind) {
        super(circuitDiagram);
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.height = height;
        this.width = width;
        this.sequenceNumber = -1 ;
        this.componentKind = componentKind;
        this.boxType = BOX.WHITE_BOX;

        //initial ports
        this.componentKind.createPorts( this, function ( port : Port ) { ports.push( port ) ; } ) ;
        this.componentKind.updatePortPositions( this ) ;

        // TODO What is going on with this loop?  What about other attributes.
        this.attributeValueList = new AttributeValueList( this.componentKind.getAttributes() ) ;
    }

    public function getAttributes( ) : Iterator< AttributeUntyped > {
        return attributeValueList.getAttributes() ;
    }
    
    public function hasAttr( attribute : AttributeUntyped ) : Bool {
        return attributeValueList.has( attribute ) ;
    }

    public function get<T : AttributeValue>( attribute : Attribute<T> ) : T {
        return attributeValueList.get( attribute ) ;
    }

    public function getUntyped( attribute : AttributeUntyped) : AttributeValue {
        return attributeValueList.getUntyped( attribute ) ;
    }

    public function canUpdate<T : AttributeValue>( attribute : Attribute<T>, value : T ) : Bool {
        return this.componentKind.canUpdate( this, attribute, value) ;
    }

    public function canUpdateUntyped( attribute : AttributeUntyped, value : AttributeValue ) : Bool {
        return this.componentKind.canUpdateUntyped( this, attribute, value) ;
    }

    public function update<T : AttributeValue>( attribute : Attribute<T>, value : T ) : Void {
        this.componentKind.update( this, attribute, value) ;
    }

    public function updateUntyped( attribute : AttributeUntyped, value : AttributeValue ) : Void {
        this.componentKind.updateUntyped( this, attribute, value) ;
    }

    public function get_xPosition():Float {
        return xPosition;
    }

    public function set_xPosition(value:Float) : Void {
        this.xPosition = value;
        this.componentKind.updatePortPositions( this ) ;
        notifyObservers(this) ;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function set_yPosition(value:Float) : Void {
        this.yPosition = value;
        this.componentKind.updatePortPositions( this ) ;
        notifyObservers(this) ;
    }

    override public function left() : Float {
        return this.xPosition - this.width/2.0 ; }

    override public function right() : Float {
        return this.xPosition + this.width/2.0 ; }

    override public function top() : Float {
        return this.yPosition - this.height/2.0 ; }

    override public function bottom() : Float {
        return this.yPosition + this.height/2.0 ; }

    public function get_orientation():Orientation {
        var attrVal = get( StandardAttributes.orientation ) ;
        return attrVal.getOrientation() ;
    }

    public function set_orientation(value:Orientation) : Void {
        update( StandardAttributes.orientation, new OrientationAttributeValue( value ) ) ;
    } 

    public function get_componentKind():ComponentKind {
        return componentKind;
    }

    public function get_boxType():BOX {
        return boxType;
    }

    public function set_boxType(value:BOX) {
        this.boxType = value;
        notifyObservers(this) ;
    }

    public function get_ports():Iterator<Port> {
        return ports.iterator();
    }

    public function get_portCount() : Int {
        return ports.length ;
    }

    public function get_name():String {
        // TODO
        return "foo" ; 
    }

    public function set_name(value:String) : Void {
        // TODO
    }

    public function get_height():Float {
        return height;
    }

    public function set_height(value:Float) {
        return this.height = value;
        notifyObservers(this) ;
    }

    public function get_width():Float {
        return width;
    }

    public function set_width(value:Float) {
        return this.width = value;
        notifyObservers(this) ;
    }

    public function getNameOfTheComponentKind() : String{
        return this.componentKind.getname();
    }

    

    public function disconnectAllPorts() {
        for( port in ports ) {
            port.disconnect() ;
        }
    }

    public function drawComponent(drawingAdpater:DrawingAdapterI, highLight:Bool, selection : SelectionModel ) {
        componentKind.drawComponent(this, drawingAdpater, highLight, selection );
    }

    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>{
        return componentKind.findHitList(this, coordinate, mode);
    }

    public function findWorldPoint(coordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        return componentKind.findWorldPoint(this, coordinate, mode);
    }

    public function getInnerCircuitDiagram() {
        return this.componentKind.getInnerCircuitDiagram() ;
    }

    public function set_sequence(n:Int) : Void {
        this.sequenceNumber = n ;
        notifyObservers(this) ;
    }

    public function get_sequence() : Int {
        return this.sequenceNumber ;
    }
}
