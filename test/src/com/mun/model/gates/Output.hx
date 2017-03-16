package com.mun.model.gates;

import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
import com.mun.model.enumeration.ValueLogic;
/**
 * output<br>
 * the output result is the same as input
 * @author wanhui
 *
 */
class Output implements ComponentKind extends GateAbstract {
    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port:Port;
        var value:ValueLogic = ValueLogic.TRUE;

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.INPUT) {//for input gate there should be have only one input port and also only one output port
                value = port.get_value();
                break;
            }
        }
        for (port in portArray) {
            if (port.get_portDescription == IOTYPE.OUTPUT) {
                portArray.remove(portArray);
                port.set_value(value);
                portArray.push(port);
            }
        }

        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, inportNum:Int = 1):Array<Port> {

        var portArray:Array<Port> = new Array<Port>();
        switch (orientation){
            case Orientation.EAST : {
                //inport
                var inport:Port = new Inport(xPosition - width / 2, yPosition);
                inport.set_sequence(1);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition + width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.NORTH : {
                //inport
                var inport:Port = new Inport(xPosition, yPosition + height / 2);
                inport.set_sequence(1);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition - height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.SOUTH : {
                var inport:Port = new Inport(xPosition, yPosition - height / 2);
                inport.set_sequence(1);
                inport.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition + height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.WEST : {
                var inport:Port = new Inport(xPosition + width / 2, yPosition);
                inport.set_sequence(1);
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

    override public function addInPort():Port {
        return null;//output should only have one inport
    }

    override public function updatePortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        return null;//cannot add any port or remove any port, therefore do not need to update the position
    }

    public function new() {
        super(1);
    }
}
