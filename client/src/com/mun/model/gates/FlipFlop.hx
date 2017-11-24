package com.mun.model.gates;

import com.mun.model.attribute.OrientationAttr;
import com.mun.model.attribute.StringAttr;
import com.mun.model.attribute.IntAttr;
import com.mun.model.attribute.Attribute;
import js.html.CanvasRenderingContext2D;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.view.drawComponents.DrawFlipFlop;
import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.VALUE_LOGIC;
/**
 * Flip-Flop<br>
 * Truth Table
 * <br>
 * <pre>
 * ****************************************
 * *|   CLK  |    D   |    Q   |    QN   |*<br>
 * *|    0   |    0   |    Q   |    QN   |*<br>
 * *|    0   |    1   |    Q   |    QN   |*<br>
 * *|    1   |    0   |    0   |    1    |*<br>
 * *|    1   |    1   |    1   |    0    |*<br>
 * ****************************************
 *  </pre>
 * @author wanhui
 *
 */
class FlipFlop implements ComponentKind extends GateAbstract {

    var nameOfTheComponentKind:String="FlipFlop";
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
            if (port.get_portDescription() == IOTYPE.CLK) {
                if (port.get_value() != VALUE_LOGIC.RISING_EDGE) {
                    //if clock is not at rising edge, then the value of flip-flop will not change
                    return portArray;
                }
            }
        }

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.D) {
                value = port.get_value();
            }
        }

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.Q) {
                port.set_value(value);
            }

            if (port.get_portDescription() == IOTYPE.QN) {
                if (value == VALUE_LOGIC.TRUE) {
                    port.set_value(VALUE_LOGIC.FALSE);
                } else if (value == VALUE_LOGIC.FALSE) {
                    port.set_value(VALUE_LOGIC.TRUE);
                }
            }
        }
        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        //flip-flop have an input inport and one clock inport
        switch (orientation){
            case ORIENTATION.EAST : {
                //inport
                var inport_D:Port = new Inport(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            case ORIENTATION.WEST : {
                //inport
                var inport_D:Port = new Inport(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            case ORIENTATION.SOUTH : {
                //inport
                var inport_D:Port = new Inport(xPosition - width / 2 + width / 3 * 1, yPosition - height / 2);
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition - width / 2 + width / 3 * 2, yPosition - height / 2);
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition - width / 2 + width / 3 * 1, yPosition + height / 2);
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition - width / 2 + width / 3 * 2, yPosition + height / 2);
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            case ORIENTATION.NORTH : {
                //inport
                var inport_D:Port = new Inport(xPosition - width / 2 + width / 3 * 1, yPosition + height / 2);
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition - width / 2 + width / 3 * 2, yPosition + height / 2);
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition - width / 2 + width / 3 * 1, yPosition - height / 2);
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition - width / 2 + width / 3 * 2, yPosition - height / 2);
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    override public function addInPort():Port {
        return null;//because flip-flop can't add any ports
    }

    /**
    * different from others, this function used in move command when the componenet has been re-located
    **/
    override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port> {
        switch (orientation){
            case ORIENTATION.EAST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.WEST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }
                }
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
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.WEST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }
                }
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    public function drawComponent(drawingAdapter:DrawingAdapterI, highLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, ?context:CanvasRenderingContext2D){
        var drawComponent:DrawComponent = new DrawFlipFlop(component, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
    }

    public function new() {
        super(2);
        Attr.push(new IntAttr());
        Attr.push(new StringAttr());
        Attr.push(new OrientationAttr());
    }
}
