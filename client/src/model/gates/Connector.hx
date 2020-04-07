package model.gates;

import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.drawComponents.DrawConnector;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
import model.selectionModel.SelectionModel ;
/**
 * Connector components connect to the world outside the circuit.
 * 
 * @author wanhui
 *
 */
class Connector implements ComponentKind extends AbstractComponentKind {

    var nameOfTheComponentKind:String="Connector";

    public function new() {
        super() ;
    }

    public function getname():String{
        return nameOfTheComponentKind;
    }

    // public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {
    //     var portArray:Array<Port> = new Array<Port>();
    //     if(true){//input should only have one input
    //         inportNum = 1;
    //     }
    //     switch (orientation){
    //         case ORIENTATION.EAST : {
    //             //inport
    //             var inport:Port = new Port(xPosition - width / 2, yPosition);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
    //             //outport
    //             var outport_:Port = new Port(xPosition + width / 2, yPosition);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case ORIENTATION.NORTH : {
    //             //inport
    //             var inport:Port = new Port(xPosition, yPosition + height / 2);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
    //             //outport
    //             var outport_:Port = new Port(xPosition, yPosition - height / 2);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case ORIENTATION.SOUTH : {
    //             var inport:Port = new Port(xPosition, yPosition - height / 2);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
    //             //outport
    //             var outport_:Port = new Port(xPosition, yPosition + height / 2);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case ORIENTATION.WEST : {
    //             var inport:Port = new Port(xPosition + width / 2, yPosition);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
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
    // /**
    // * different from others, this function used in move command when the componenet has been re-located
    // **/
    // override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port> {
    //     switch (orientation){
    //         case ORIENTATION.EAST : {
    //             portArray[0].set_xPosition(xPosition - width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         case ORIENTATION.NORTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition + height / 2);
    //         };
    //         case ORIENTATION.SOUTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition - height / 2);
    //         };
    //         case ORIENTATION.WEST : {
    //             portArray[0].set_xPosition(xPosition + width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         default : {
    //             //do nothing
    //         }
    //     }
    //     return portArray;
    // }
    // /**
    // * different from others, this function used in move command when the componenet has been re-located
    // **/
    // override public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port>{
    //     switch (orientation){
    //         case ORIENTATION.EAST : {
    //             portArray[0].set_xPosition(xPosition + width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         case ORIENTATION.NORTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition - height / 2);
    //         };
    //         case ORIENTATION.SOUTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition + height / 2);
    //         };
    //         case ORIENTATION.WEST : {
    //             portArray[0].set_xPosition(xPosition - width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         default : {
    //             //do nothing
    //         }
    //     }
    //     return portArray;
    // }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool, selection : SelectionModel){
        var drawComponent:DrawConnector = new DrawConnector(component, drawingAdapter, highlight);
        drawComponent.drawCorrespondingComponent() ;
    }
}
