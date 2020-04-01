package model.component;

import model.selectionModel.SelectionModel;
import model.attribute.Pair;
import model.observe.Observable;
import type.HitObject;
import model.enumeration.BOX;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import type.Coordinate;
import type.WorldPoint;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
import model.gates.ComponentKind;
import assertions.Assert;
import model.attribute.StringAttr;
import model.attribute.NamePair;
import model.attribute.OrientationAttr;
import model.attribute.OrientationPair;
import model.attribute.IntAttr;
import model.attribute.DelayPair;
import model.attribute.AttrValue;
import model.attribute.StringValue;
import model.attribute.IntValue;
import model.attribute.OrientationValue;

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
    var list:Map<String,Pair>=new Map<String,Pair>();
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
    public function new(circuitDiagram : CircuitDiagramI, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, componentKind:ComponentKind, inportNum:Int) {
        super(circuitDiagram);
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.height = height;
        this.width = width;
        this.sequenceNumber = -1 ;
        this.componentKind = componentKind;
        this.boxType = BOX.WHITE_BOX;

        //this.delay = 0;//init is zero

        //initial ports
        this.componentKind.createPorts( this, function ( port : Port ) { ports.push( port ) ; } ) ;
        this.componentKind.updatePortPositions( this ) ;

        // TODO What is going on with this loop?  What about other attributes.
        for(n in componentKind.getAttr()){
            if(n.getName()=="delay"){
                list.set(n.getName(),new DelayPair(cast(n,IntAttr),cast(n,IntAttr).getdefaultvalue()));
            }
            else if(n.getName()=="name"){
                list.set(n.getName(),new NamePair(cast(n,StringAttr),cast(n,StringAttr).getdefaultvalue()));
            }
            else if(n.getName()=="orientation"){
                list.set(n.getName(),new OrientationPair(cast(n,OrientationAttr),cast(n,OrientationAttr).getdefaultvalue()));
            }
        }
        list.get("orientation").update(this,new OrientationValue(orientation));
    }
    
    public function getmap(){
        return list;
    }

    public function hasAttr(s:String):Bool{
        return list.exists(s);
    }

    public function getAttr(s:String):AttrValue{
        Assert.assert(list.exists(s));
        return list.get(s).getAttrValue();
    }

    public function getAttrInt(s:String):Int{
        Assert.assert(list.exists(s));
        return list.get(s).getAttrValue().getvalue();
    }

    public function canupdate(s:String,v:AttrValue):Bool{
        Assert.assert(list.exists(s));
        if(list.exists(s)){
            return list.get(s).canupdate(this,v);
        }
        return false;
    }

    public function update(s:String, v:AttrValue):Bool{
        Assert.assert(list.exists(s));
        if(list.exists(s)){
            if(list.get(s).canupdate(this,v)){
                var success =  list.get(s).update(this,v);
                if( success ) notifyObservers(this) ;
                return success ;
            }
        }
        return false;
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

    public function get_orientation():ORIENTATION {
        return list.get("orientation").getAttrValue().getvalue();
    }

    public function set_orientation(value:ORIENTATION) : Void {
        update("orientation",new OrientationValue(value));
        this.componentKind.updatePortPositions( this ) ;
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
        return list.get("name").getAttrValue().getvalue();
    }

    public function set_name(value:String) {
        update("name",new StringValue(value));
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
