package com.mun.model.gates;

import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.view.drawComponents.DrawXOR;
import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.VALUE_LOGIC;
/**
 * XOR gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    0   |*<br>
 * *|   0    |    1    |    1   |*<br>
 * *|   1    |    0    |    1   |*<br>
 * *|   0    |    0    |    0   |*<br>
 * *******************************
 *  </pre>
 * @author wanhui
 *
 */
class XOR implements ComponentKind extends GateAbstract {
    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port:Port;
        var value:VALUE_LOGIC;
        var counter:Int = 0;//counter
        //for 2 or more inputs, if the number of  ValueLogic.TRUE is even, the output should be ValueLogic.FALSE
        //otherwise, the output should be ValueLogic.TRUE
        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.INPUT && port.get_value() == VALUE_LOGIC.TRUE) {
                counter++;
            }
        }

        if (counter % 2 == 0) {
            value = VALUE_LOGIC.FALSE;
        } else {
            value = VALUE_LOGIC.TRUE;
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
        if(inportNum == null || inportNum <2){
            inportNum = 2;
        }
        switch (orientation){
            case ORIENTATION.EAST : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition - width / 2, height / (inportNum + 1) * (counter + 1) + (yPosition - height / 2));
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
                //outport
                var outport_:Port = new Outport(xPosition + width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.NORTH : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition - width / 2 + width / (inportNum + 1) * (counter + 1), yPosition + height / 2);
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
                //outport
                var outport_:Port = new Outport(xPosition, yPosition - height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.SOUTH : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition - width / 2 + width / (inportNum + 1) * (counter + 1), yPosition - height / 2);
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
                //outport
                var outport_:Port = new Outport(xPosition, yPosition + height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case ORIENTATION.WEST : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition + width / 2, height / (inportNum + 1) * (counter + 1) + (yPosition - height / 2));
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
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

    public function drawComponent(drawingAdapter:DrawingAdapterI, highLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        var drawComponent:DrawComponent = new DrawXOR(component, drawingAdapter);
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
