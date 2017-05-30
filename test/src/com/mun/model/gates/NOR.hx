package com.mun.model.gates;

import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.view.drawComponents.DrawNOR;
import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.Orientation;
import com.mun.model.enumeration.ValueLogic;
/**
 * NOR gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    0   |*<br>
 * *|   0    |    1    |    0   |*<br>
 * *|   1    |    0    |    0   |*<br>
 * *|   0    |    0    |    1   |*<br>
 * *******************************
 *  </pre>
 * @author wanhui
 *
 */
class NOR implements ComponentKind extends GateAbstract {
    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port:Port;
        var value:ValueLogic = ValueLogic.TRUE;

        for (port in portArray) {
            if (port.get_portDescription() == IOTYPE.INPUT && port.get_value() == ValueLogic.TRUE) {
                value = ValueLogic.FALSE;
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
        if(inportNum == null || inportNum<2){
            inportNum = 2;
        }
        switch (orientation){
            case Orientation.EAST : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition - width / 2, height / (inportNum + 1) * (counter + 1) + (yPosition - height / 2));
                    inport.set_sequence(counter + 1);
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
                //outport
                var outport_:Port = new Outport(xPosition + width / 2, yPosition);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.NORTH : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition - width / 2 + width / (inportNum + 1) * (counter + 1), yPosition + height / 2);
                    inport.set_sequence(counter + 1);
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
                //outport
                var outport_:Port = new Outport(xPosition, yPosition - height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.SOUTH : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition - width / 2 + width / (inportNum + 1) * (counter + 1), yPosition - height / 2);
                    inport.set_sequence(counter + 1);
                    inport.set_portDescription(IOTYPE.INPUT);
                    portArray.push(inport);
                    counter++;
                }
                //outport
                var outport_:Port = new Outport(xPosition, yPosition + height / 2);
                outport_.set_portDescription(IOTYPE.OUTPUT);
                portArray.push(outport_);
            };
            case Orientation.WEST : {
                var counter:Int = 0;
                //inport
                while (counter < inportNum) {
                    var inport:Port = new Inport(xPosition + width / 2, height / (inportNum + 1) * (counter + 1) + (yPosition - height / 2));
                    inport.set_sequence(counter + 1);
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

    public function drawComponent(component:Component, drawingAdapter:DrawingAdapterI, highLight:Bool){
        var drawComponent:DrawComponent = new DrawNOR(component, drawingAdapter);
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
