package com.mun.model.gates;


import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
import com.mun.model.enumeration.ValueLogic;
/**
 * 2-1 MUX<br>
 * For MUX, the format in the map should be like this:<br>
 * (IO.S, ValueLogic),(IO.INPUT, valueLogic),(IO.INPUT, valueLogic)<br>
 * IO.S must put in the first place<br>
 * Truth Table
 * <br>
 * <pre>
 * ***************************************
 * *|   S   |input 1 | input 2 | output |*<br>
 * *|   0   |   1    |    1    |    1   |*<br>
 * *|   0   |   1    |    0    |    1   |*<br>
 * *|   0   |   0    |    1    |    0   |*<br>
 * *|   0   |   0    |    0    |    0   |*<br>
 * *|   1   |   1    |    1    |    1   |*<br>
 * *|   1   |   1    |    0    |    0   |*<br>
 * *|   1   |   0    |    1    |    1   |*<br>
 * *|   1   |   0    |    0    |    0   |*<br>
 * ***************************************
 *  </pre>
 * @author wanhui
 *
 */
class MUX implements ComponentKind extends GateAbstract {

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port:Port;
        var value:ValueLogic = ValueLogic.TRUE;
        var selectValue:ValueLogic = ValueLogic.FALSE;

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.S) {
                selectValue = port.get_value();
                break;
            }
        }

        //if s == 1 the output should as the same as the input 2
        if (selectValue == ValueLogic.TRUE) {
            for (port in portArray) {
                if (port.get_sequence() == 1) {
                    value = port.get_value();
                    break;
                }
            }
        } else if (selectValue == ValueLogic.FALSE) {//if S == 0, the output should as the same as input 1
            for (port in portArray) {
                if (port.get_sequence() == 0) {
                    value = port.get_value();
                    break;
                }
            }
        }

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.OUTPUT) {
                portArray.remove(port);
                port.set_value(value);
                portArray.push(port);
                break;
            }
        }
        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, ?inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        //mux have one select inport and two input inports
        switch (orientation){
            case Orientation.EAST : {
                //inport
                var inport_S:Port = new Inport(xPosition, yPosition - height / 2);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_1.set_portDescription(IOTYPE.INPUT);
                inport_1.set_sequence(0);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_2.set_portDescription(IOTYPE.INPUT);
                inport_2.set_sequence(1);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition + width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.WEST : {
                //inport
                var inport_S:Port = new Inport(xPosition, yPosition - height / 2);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_1.set_portDescription(IOTYPE.INPUT);
                inport_1.set_sequence(0);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_2.set_portDescription(IOTYPE.INPUT);
                inport_2.set_sequence(1);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition - width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.SOUTH : {
                //inport
                var inport_S:Port = new Inport(xPosition - width / 2, yPosition);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition - width / 2 + height / 3 * 2, yPosition - height / 2);
                inport_1.set_portDescription(IOTYPE.INPUT);
                inport_1.set_sequence(0);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition - width / 2 + width / 3, yPosition - height / 2);
                inport_2.set_portDescription(IOTYPE.INPUT);
                inport_2.set_sequence(1);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition + height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.NORTH : {
                //inport
                var inport_S:Port = new Inport(xPosition + width / 2, yPosition);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition - width / 2 + height / 3 * 2, yPosition + height / 2);
                inport_1.set_portDescription(IOTYPE.INPUT);
                inport_1.set_sequence(0);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition - width / 2 + width / 3, yPosition + height / 2);
                inport_2.set_portDescription(IOTYPE.INPUT);
                inport_2.set_sequence(1);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition - height / 2);
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
    override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        switch (orientation){
            case Orientation.EAST : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                        if (portArray[i].get_sequence() == -1) {
                            portArray[i].set_sequence(i);
                        }
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition);
                        portArray[i].set_yPosition(yPosition - height/2);
                    }
                }
            };
            case Orientation.NORTH : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                        portArray[i].set_yPosition(yPosition + height / 2);
                        if (portArray[i].get_sequence() == -1) {
                            portArray[i].set_sequence(i);
                        }
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition - width/2);
                        portArray[i].set_yPosition(yPosition);
                    }
                }
            };
            case Orientation.SOUTH : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                        portArray[i].set_yPosition(yPosition - height / 2);
                        if (portArray[i].get_sequence() == -1) {
                            portArray[i].set_sequence(i);
                        }
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition + width/2);
                        portArray[i].set_yPosition(yPosition);
                    }
                }
            };
            case Orientation.WEST : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                        if (portArray[i].get_sequence() == -1) {
                            portArray[i].set_sequence(i);
                        }
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition);
                        portArray[i].set_yPosition(yPosition - height/2);
                    }
                }
            };
            default:{
                //do nothing
            }
        }
        return portArray;
    }
        public function new() {
        super(2);
    }
}
