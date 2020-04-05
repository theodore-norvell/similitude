package model.gates;

import model.attribute.OrientationAttr;
import model.attribute.StringAttr;
import model.attribute.IntAttr;
import model.attribute.Attribute;
import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.drawComponents.DrawOR;
import model.selectionModel.SelectionModel ;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
/**
 * OR gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    1   |*<br>
 * *|   0    |    1    |    1   |*<br>
 * *|   1    |    0    |    1   |*<br>
 * *|   0    |    0    |    0   |*<br>
 * *******************************
 *  </pre>
 * @author wanhui
 *
 */
class OR implements ComponentKind extends AbstractGate {

    var nameOfTheComponentKind:String="OR";

    public function new() {
        super() ;
        attributes.push(new IntAttr("delay"));
    }

    public function getname():String{
        return nameOfTheComponentKind;
    }

    // public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {
    //     var portArray:Array<Port> = new Array<Port>();
    //     if(inportNum == null || inportNum < 3){
    //         inportNum = 2;
    //     }
    //     switch (orientation){
    //         case ORIENTATION.EAST : {
    //             var counter:Int = 0;
    //             //inport
    //             while (counter < inportNum) {
    //                 var inport:Port = new Port(xPosition - width / 2,
    //                                              height / (inportNum + 1) * (counter + 1) + (yPosition - height / 2));
    //                 inport.set_portDescription(IOTYPE.INPUT);
    //                 portArray.push(inport);
    //                 counter++;
    //             }
    //             //outport
    //             var outport_:Port = new Port(xPosition + width / 2, yPosition);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case ORIENTATION.NORTH : {
    //             var counter:Int = 0;
    //             //inport
    //             while (counter < inportNum) {
    //                 var inport:Port = new Port(xPosition - width / 2 + width / (inportNum + 1) * (counter + 1), yPosition + height / 2);
    //                 inport.set_portDescription(IOTYPE.INPUT);
    //                 portArray.push(inport);
    //                 counter++;
    //             }
    //             //outport
    //             var outport_:Port = new Port(xPosition, yPosition - height / 2);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case ORIENTATION.SOUTH : {
    //             var counter:Int = 0;
    //             //inport
    //             while (counter < inportNum) {
    //                 var inport:Port = new Port(xPosition - width / 2 + width / (inportNum + 1) * (counter + 1), yPosition - height / 2);
    //                 inport.set_portDescription(IOTYPE.INPUT);
    //                 portArray.push(inport);
    //                 counter++;
    //             }
    //             //outport
    //             var outport_:Port = new Port(xPosition, yPosition + height / 2);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case ORIENTATION.WEST : {
    //             var counter:Int = 0;
    //             //inport
    //             while (counter < inportNum) {
    //                 var inport:Port = new Port(xPosition + width / 2, height / (inportNum + 1) * (counter + 1) + (yPosition - height / 2));
    //                 inport.set_portDescription(IOTYPE.INPUT);
    //                 portArray.push(inport);
    //                 counter++;
    //             }
    //             //outport
    //             var outport_:Port = new Port(xPosition - width / 2, yPosition);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         default : {
    //             //do nothing
    //         }
    //     }
    //     return portArray;
    // }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highLight:Bool, selection : SelectionModel){
        var drawComponent:DrawOR = new DrawOR(component, drawingAdapter, highLight);
        drawComponent.drawCorrespondingComponent();
    }
}
