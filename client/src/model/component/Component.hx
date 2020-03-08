package model.component;

import model.attribute.Pair;
import model.observe.Observable;
//import js.html.CanvasRenderingContext2D;
import type.LinkAndComponentAndEndpointAndPortArray;
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
class Component extends Observable{
    var xPosition:Float;//the x position of the component
    var yPosition:Float;//the y position of the component
    var height:Float;//height
    var width:Float;//width
    //var orientation:ORIENTATION;//the orientation of the component
    var componentKind:ComponentKind;//the actual gate in this component
    var inportArray:Array<Port> = new Array<Port>();//the inports for the component
    var outportArray:Array<Port> = new Array<Port>();//the outports for the component
    var inportsNum:Int;//init
    //var nameOfTheComponentKind:String;//the actually name of this componentkind, like "AND", "OR"      if the component is a compound component, this value would be "CC"
    var boxType:BOX;
    var list:Map<String,Pair>=new Map<String,Pair>();
    var cd:CircuitDiagram;
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
    public function new(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, componentKind:ComponentKind, inportNum:Int) {
        super();
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.height = height;
        this.width = width;
        this.componentKind = componentKind;
        this.componentKind.set_component(this);
        this.inportsNum = inportNum;
        this.boxType = BOX.WHITE_BOX;

        //this.delay = 0;//init is zero

        //initial ports
        var portArray:Array<Port> = new Array<Port>();
        portArray = this.componentKind.createPorts(xPosition, yPosition, width, height, orientation, inportNum);
        for (o in 0...portArray.length) {
            var port:Port = portArray[o];
            if (port.get_portDescription() == IOTYPE.INPUT || port.get_portDescription() == IOTYPE.CLK || port.get_portDescription() == IOTYPE.D ||
                port.get_portDescription() == IOTYPE.S) {
                inportArray.push(port);
            } else {
                outportArray.push(port);
            }

        }
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
                return list.get(s).update(this,v);
            }
        }
        return false;
    }

    public function get_CircuitDiagram():CircuitDiagram{
        return cd;
    }

    public function get_xPosition():Float {
        return xPosition;
    }

    public function set_xPosition(value:Float) {
        return this.xPosition = value;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function set_yPosition(value:Float) {
        return this.yPosition = value;
    }

    public function get_orientation():ORIENTATION {
        return list.get("orientation").getAttrValue().getvalue();
    }

    public function set_orientation(value:ORIENTATION) {
        list.get("orientation").update(this,new OrientationValue(value));
    }

    public function get_componentKind():ComponentKind {
        return componentKind;
    }

    public function set_componentKind(value:ComponentKind) {
        return this.componentKind = value;
    }

    public function get_boxType():BOX {
        return boxType;
    }

    public function set_boxType(value:BOX) {
        this.boxType = value;
    }

    public function get_inportIterator():Iterator<Port> {
        return inportArray.iterator();
    }
    public function get_inportIteratorLength():Int {
        return inportArray.length;
    }

    public function get_outportIteratorLength():Int {
        return outportArray.length;
    }

    public function get_outportIterator():Iterator<Port> {
        return outportArray.iterator();
    }

    public function get_name():String {
        return list.get("name").getAttrValue().getvalue();
    }

    public function set_name(value:String) {
        list.get("name").update(this,new StringValue(value));
    }

    public function get_height():Float {
        return height;
    }

    public function set_height(value:Float) {
        return this.height = value;
    }

    public function get_width():Float {
        return width;
    }

    public function set_width(value:Float) {
        return this.width = value;
    }

    public function get_inportsNum():Int {
        return inportsNum;
    }
    public function setNameOfTheComponentKind(name:String){
        //this.nameOfTheComponentKind = name;
    }
    public function getNameOfTheComponentKind():String{
        return this.componentKind.getname();
    }

    public function removeInport(inport:Inport):Bool {
        return inportArray.remove(inport);
    }
    public function updateMoveComponentPortPosition(xPosition:Float, yPosition:Float):Component{
        inportArray = componentKind.updateInPortPosition(inportArray, xPosition, yPosition, height, width, list.get("orientation").getAttrValue().getvalue());
        outportArray = componentKind.updateOutPortPosition(outportArray, xPosition, yPosition, height, width, list.get("orientation").getAttrValue().getvalue());
        return this;
    }

    public function drawComponent(drawingAdpater:DrawingAdapterI, highLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray ){
        if(componentKind.checkInnerCircuitDiagramPortsChange()){

            for(i in componentKind.getInnerCircuitDiagram().get_componentIterator()){
                var inputFlag:Bool = false;
                var outputFlag:Bool = false;
                for(j in inportArray){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        if(i.get_componentKind().get_sequence() == j.get_sequence()){
                            inputFlag = true;
                        }
                    }
                }

                for(j in outportArray){
                    if(i.getNameOfTheComponentKind() == "Output"){
                        if(i.get_componentKind().get_sequence() == j.get_sequence()){
                            outputFlag = true;
                        }
                    }
                }

                if(!inputFlag && !outputFlag){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        var port:Port = componentKind.addInPort();
                        port.set_sequence(i.get_componentKind().get_sequence());
                        inportArray.push(port);
                    }else{
                        var port:Port = componentKind.addOutPort();
                        port.set_sequence(i.get_componentKind().get_sequence());
                        outportArray.push(port);
                    }
                }
            }

            for(i in inportArray){
                var flag_delete:Bool = true;
                for(j in componentKind.getInnerCircuitDiagram().get_componentIterator()){
                    if(i.get_sequence() == j.get_componentKind().get_sequence() && j.getNameOfTheComponentKind() == "Input"){
                        flag_delete = false;
                    }
                }

                if(flag_delete){
                    inportArray.remove(i);
                }
            }

            for(i in outportArray){
                var flag_delete:Bool = true;
                for(j in componentKind.getInnerCircuitDiagram().get_componentIterator()){
                    if(i.get_sequence() == j.get_componentKind().get_sequence() && j.getNameOfTheComponentKind() == "Output"){
                        flag_delete = false;
                    }
                }

                if(flag_delete){
                    outportArray.remove(i);
                }
            }

            componentKind.updateInPortPosition(inportArray, xPosition, yPosition, height, width, list.get("orientation").getAttrValue().getvalue());
            componentKind.updateOutPortPosition(outportArray, xPosition, yPosition, height, width, list.get("orientation").getAttrValue().getvalue());
        }
        if(this.componentKind.getname()!= "CC"){
            componentKind.drawComponent(drawingAdpater, highLight);
        }else{
            componentKind.drawComponent(drawingAdpater, highLight, linkAndComponentArray);
        }
    }

    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>{
        return componentKind.findHitList(coordinate, mode);
    }

    public function findWorldPoint(coordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        return componentKind.findWorldPoint(coordinate, mode);
    }
}
