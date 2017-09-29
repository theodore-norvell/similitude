package com.mun.model.gates;


import js.html.CanvasRenderingContext2D;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.view.drawComponents.DrawMUX;
import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.VALUE_LOGIC;
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
        var value:VALUE_LOGIC = VALUE_LOGIC.TRUE;
        var selectValue:VALUE_LOGIC = VALUE_LOGIC.FALSE;

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.S) {
                selectValue = port.get_value();
                break;
            }
        }

        //if s == 1 the output should as the same as the input 2
        if (selectValue == VALUE_LOGIC.TRUE) {
            for (port in portArray) {
                if (port.get_sequence() == 1) {
                    value = port.get_value();
                    break;
                }
            }
        } else if (selectValue == VALUE_LOGIC.FALSE) {//if S == 0, the output should as the same as input 1
            for (port in portArray) {
                if (port.get_sequence() == 0) {
                    value = port.get_value();
                    break;
                }
            }
        }

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.OUTPUT) {
                port.set_value(value);
                break;
            }
        }
        return portArray;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        //mux have one select inport and two input inports
        switch (orientation){
            case ORIENTATION.EAST : {
                //inport
                var inport_S:Port = new Inport(xPosition, yPosition - height / 2);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_1.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_2.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition + width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.WEST : {
                //inport
                var inport_S:Port = new Inport(xPosition, yPosition - height / 2);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_1.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_2.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition - width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.SOUTH : {
                //inport
                var inport_S:Port = new Inport(xPosition - width / 2, yPosition);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition - width / 2 + height / 3 * 2, yPosition - height / 2);
                inport_1.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition - width / 2 + width / 3, yPosition - height / 2);
                inport_2.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_2);
                //outport
                var outport_:Port = new Outport(xPosition, yPosition + height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.NORTH : {
                //inport
                var inport_S:Port = new Inport(xPosition + width / 2, yPosition);
                inport_S.set_portDescription(IOTYPE.S);
                portArray.push(inport_S);
                var inport_1:Port = new Inport(xPosition - width / 2 + height / 3 * 2, yPosition + height / 2);
                inport_1.set_portDescription(IOTYPE.INPUT);
                portArray.push(inport_1);
                var inport_2:Port = new Inport(xPosition - width / 2 + width / 3, yPosition + height / 2);
                inport_2.set_portDescription(IOTYPE.INPUT);
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
    override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port> {
        switch (orientation){
            case ORIENTATION.EAST : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition);
                        portArray[i].set_yPosition(yPosition - height/2);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition - width/2);
                        portArray[i].set_yPosition(yPosition);
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }else{//IOTYPE.S
                        portArray[i].set_xPosition(xPosition + width/2);
                        portArray[i].set_yPosition(yPosition);
                    }
                }
            };
            case ORIENTATION.WEST : {
                for (i in 0...portArray.length) {
                    if (portArray[i].get_portDescription() != IOTYPE.S) {
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
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

    public function drawComponent(drawingAdapter:DrawingAdapterI, highLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, ?context:CanvasRenderingContext2D){
        var drawComponent:DrawComponent = new DrawMUX(component, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
    }

    public function new() {
        super(2);
    }
}
