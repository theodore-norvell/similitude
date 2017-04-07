package com.mun.model.gates;


import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
import com.mun.model.enumeration.ValueLogic;
/**
 * input<br>
 * the output is the same as input
 * @author wanhui
 *
 */
class Input implements ComponentKind extends GateAbstract {
    var sequence:Int;//the sequence of the input order in the diagram, the initial value is 1

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
            if (port.get_portDescription() == IOTYPE.OUTPUT) {
                portArray.remove(port);
                port.set_value(value);
                portArray.push(port);
            }
        }

        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, ?inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        if(true){//input should only have one input
            inportNum = 1;
        }
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

    public function new() {
        super(1);
    }

    function get_sequence():Int {
        return sequence;
    }

    function set_sequence(value:Int) {
        return this.sequence = value;
    }

    override public function addInPort():Port {
        return null;//intput should only have one inport
    }

    override public function updatePortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        return null;//cannot add any port or remove any port, therefore do not need to update the position
    }
}
