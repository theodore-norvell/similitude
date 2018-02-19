package com.mun.model.gates;

import com.mun.model.attribute.OrientationAttr;
import com.mun.model.attribute.StringAttr;
import com.mun.model.attribute.IntAttr;
import com.mun.model.attribute.Attribute;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.view.drawComponents.DrawNOT;
import com.mun.model.component.Inport;
import com.mun.model.component.Outport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ORIENTATION;
/**
 * NOT gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *********************
 * *|input 1 | output |*<br>
 * *|   1    |    0   |*<br>
 * *|   0    |    1   |*<br>
 * *********************
 *  </pre>
 * @author wanhui
 *
 */
class NOT implements ComponentKind extends AbstractComponentKind {

    var nameOfTheComponentKind:String="NOT";

    public function new() {
        super() ;
        attributes.push(new IntAttr("delay"));
    }

    public function setname(s:String):Void{
        nameOfTheComponentKind=s;
    }

    public function getname():String{
        return nameOfTheComponentKind;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        if(true){//not gate not have one input
            inportNum = 1;
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
        var drawComponent:DrawComponent = new DrawNOT(component, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
    }
}
