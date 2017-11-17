package com.mun.model.gates;

import haxe.ds.ArraySort;
import com.mun.model.attribute.StringAttr;
import com.mun.model.attribute.Attribute;
import js.html.CanvasRenderingContext2D;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.view.drawComponents.DrawOutput;
import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.VALUE_LOGIC;
/**
 * output<br>
 * the output result is the same as input
 * @author wanhui
 *
 */
class Output implements ComponentKind extends GateAbstract {

    var nameOfTheComponentKind:String="Output";
    var Attr:Array<Attribute>=new Array<Attribute>();
    var delay:Int=0;//delay of the component

    public function getAttr():Array<Attribute>{
        return Attr;
    }

    public function getDelay():Int{
        return delay;
    }

    public function setDelay(value:Int):Int{
        var a:Int=delay;
        delay=value;
        return a;
    }

    public function getname():String{
        return nameOfTheComponentKind;
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port:Port;
        var value:VALUE_LOGIC = VALUE_LOGIC.TRUE;

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.INPUT) {//for input gate there should be have only one input port and also only one output port
                value = port.get_value();
                break;
            }
        }
        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.OUTPUT) {
                port.set_value(value);
            }
        }

        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {

        var portArray:Array<Port> = new Array<Port>();
        if(true){//output only have one input
            inportNum = 1;
        }
        switch (orientation){
            case ORIENTATION.EAST : {
                //inport
                var inport:Port = new Inport(xPosition - width / 2, yPosition);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition + width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.NORTH : {
                //inport
                var inport:Port = new Inport(xPosition, yPosition + height / 2);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition - height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.SOUTH : {
                var inport:Port = new Inport(xPosition, yPosition - height / 2);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition + height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.WEST : {
                var inport:Port = new Inport(xPosition + width / 2, yPosition);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition - width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    /**
    * different from others, this function used in move command when the componenet has been re-located
    **/
    override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port> {
        switch (orientation){
            case ORIENTATION.EAST : {
                portArray[0].set_xPosition(xPosition - width / 2);
                portArray[0].set_yPosition(yPosition);
            };
            case ORIENTATION.NORTH : {
                portArray[0].set_xPosition(xPosition);
                portArray[0].set_yPosition(yPosition + height / 2);
            };
            case ORIENTATION.SOUTH : {
                portArray[0].set_xPosition(xPosition);
                portArray[0].set_yPosition(yPosition - height / 2);
            };
            case ORIENTATION.WEST : {
                portArray[0].set_xPosition(xPosition + width / 2);
                portArray[0].set_yPosition(yPosition);
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }
    /**
    * different from others, this function used in move command when the componenet has been re-located
    **/
    override public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port>{
        switch (orientation){
            case ORIENTATION.EAST : {
                portArray[0].set_xPosition(xPosition + width / 2);
                portArray[0].set_yPosition(yPosition);
            };
            case ORIENTATION.NORTH : {
                portArray[0].set_xPosition(xPosition);
                portArray[0].set_yPosition(yPosition - height / 2);
            };
            case ORIENTATION.SOUTH : {
                portArray[0].set_xPosition(xPosition);
                portArray[0].set_yPosition(yPosition + height / 2);
            };
            case ORIENTATION.WEST : {
                portArray[0].set_xPosition(xPosition - width / 2);
                portArray[0].set_yPosition(yPosition);
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    public function drawComponent(drawingAdapter:DrawingAdapterI, highLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, ?context:CanvasRenderingContext2D){
        var drawComponent:DrawComponent = new DrawOutput(component, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
    }

    public function new() {
        super(1);
        Attr.push(new StringAttr("name"));
    }
}
