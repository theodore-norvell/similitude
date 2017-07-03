package com.mun.model.component;

import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.enumeration.MODE;
import com.mun.type.Type.Coordinate;
import com.mun.type.Type.WorldPoint;
import com.mun.type.Type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
import com.mun.model.gates.ComponentKind;
/**
 * Component composite by gates and ports, in this class
 * will composite gates and ports into one entity.
 * @author wanhui
 *
 */
class Component {
    var xPosition:Float;//the x position of the component
    var yPosition:Float;//the y position of the component
    var height:Float;//height
    var width:Float;//width
    var orientation:Orientation;//the orientation of the component
    var componentKind:ComponentKind;//the actual gate in this component
    var inportArray:Array<Port> = new Array<Port>();//the inports for the component
    var outportArray:Array<Port> = new Array<Port>();//the outports for the component
    var name:String = "";//the name of the component, unique
    var delay:Int;//delay of the component
    var inportsNum:Int;//init
    var nameOfTheComponentKind:String;//the actually name of this componentkind, like "AND", "OR"      if the component is a compound component, this value would be "CC"
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
    public function new(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, componentKind:ComponentKind, inportNum:Int) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.height = height;
        this.width = width;
        this.orientation = orientation;
        this.componentKind = componentKind;
        this.componentKind.set_component(this);
        this.inportsNum = inportNum;

        this.delay = 0;//init is zero

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

    public function get_orientation():Orientation {
        return orientation;
    }

    public function set_orientation(value:Orientation) {
        return this.orientation = value;
    }

    public function get_componentKind():ComponentKind {
        return componentKind;
    }

    public function set_componentKind(value:ComponentKind) {
        return this.componentKind = value;
    }

    public function get_inportIterator():Iterator<Port> {
        return inportArray.iterator();
    }

    public function get_outportIterator():Iterator<Port> {
        return outportArray.iterator();
    }

    public function get_name():String {
        return name;
    }

    public function set_name(value:String) {
        return this.name = value;
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

    public function get_delay():Int {
        return delay;
    }

    public function set_delay(value:Int) {
        return this.delay = value;
    }

    public function get_inportsNum():Int {
        return inportsNum;
    }
    public function setNameOfTheComponentKind(name:String){
        this.nameOfTheComponentKind = name;
    }
    public function getNameOfTheComponentKind():String{
        return this.nameOfTheComponentKind;
    }
    public function set_inportsNum(value:Int):Bool {
        if (value <= componentKind.getLeastInportNumber()) {
            return false;
        }
        this.inportsNum = value;
        while (inportArray.length < value) {
            if (componentKind.addInPort() != null) {
                inportArray.push(componentKind.addInPort());
            } else {
                return false;
            }
        }
        this.inportArray = componentKind.updateInPortPosition(inportArray, xPosition, yPosition, height, width, orientation);
        return true;
    }

    public function removeInport(inport:Inport):Bool {
        return inportArray.remove(inport);
    }
    public function updateMoveComponentPortPosition(xPosition:Float, yPosition:Float):Component{
        inportArray = componentKind.updateInPortPosition(inportArray, xPosition, yPosition, height, width, orientation);
        outportArray = componentKind.updateOutPortPosition(outportArray, xPosition, yPosition, height, width, orientation);
        return this;
    }

    public function drawComponent(drawingAdpater:DrawingAdapterI, highLight:Bool){
        componentKind.drawComponent(drawingAdpater, highLight);
    }

    public function findHitList(coordinate:Coordinate, mode:MODE):LinkAndComponentAndEndpointAndPortArray{
        return componentKind.findHitList(coordinate, mode);
    }

    public function findWorldPoint(coordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        return componentKind.findWorldPoint(coordinate, mode);
    }
}
