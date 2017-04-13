package com.mun.model.gates;


import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
import com.mun.model.enumeration.ValueLogic;
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

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port:Port;
        var value:ValueLogic = ValueLogic.TRUE;

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.CLK) {
                if (port.get_value() != ValueLogic.RISING_EDGE) {
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
                portArray.remove(port);
                port.set_value(value);
                portArray.push(port);
            }

            if (port.get_portDescription() == IOTYPE.QN) {
                portArray.remove(port);
                if (value == ValueLogic.TRUE) {
                    port.set_value(ValueLogic.FALSE);
                } else if (value == ValueLogic.FALSE) {
                    port.set_value(ValueLogic.TRUE);
                }
                portArray.push(port);
            }
        }
        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, ?inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        //flip-flop have an input inport and one clock inport
        switch (orientation){
            case Orientation.EAST : {
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
            case Orientation.WEST : {
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
            case Orientation.SOUTH : {
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
            case Orientation.NORTH : {
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
    override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        switch (orientation){
            case Orientation.EAST : {
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
            case Orientation.WEST : {
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
            case Orientation.SOUTH : {
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
            case Orientation.NORTH : {
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
    override public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>{
        switch (orientation){
            case Orientation.EAST : {
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
            case Orientation.WEST : {
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
            case Orientation.SOUTH : {
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
            case Orientation.NORTH : {
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
    public function new() {
        super(2);
    }
}
