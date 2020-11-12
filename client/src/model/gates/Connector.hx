package model.gates;

import model.component.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
import model.selectionModel.SelectionModel ;
/**
 * Connector components connect to the world outside the circuit.
 * 
 * @author wanhui
 *
 */
class Connector implements ComponentKind extends AbstractComponentKind implements ComponentKind {

    public function new() {
        super("Connector") ;
    }

    // public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, ?inportNum:Int):Array<Port> {
    //     var portArray:Array<Port> = new Array<Port>();
    //     if(true){//input should only have one input
    //         inportNum = 1;
    //     }
    //     switch (orientation){
    //         case Orientation.EAST : {
    //             //inport
    //             var inport:Port = new Port(xPosition - width / 2, yPosition);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
    //             //outport
    //             var outport_:Port = new Port(xPosition + width / 2, yPosition);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case Orientation.NORTH : {
    //             //inport
    //             var inport:Port = new Port(xPosition, yPosition + height / 2);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
    //             //outport
    //             var outport_:Port = new Port(xPosition, yPosition - height / 2);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case Orientation.SOUTH : {
    //             var inport:Port = new Port(xPosition, yPosition - height / 2);
    //             inport.set_portDescription(IOTYPE.INPUT);
    //             portArray.push(inport);
    //             //outport
    //             var outport_:Port = new Port(xPosition, yPosition + height / 2);
    //             outport_.set_portDescription(IOTYPE.OUTPUT);
    //             portArray.push(outport_);
    //         };
    //         case Orientation.WEST : {
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
    // override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
    //     switch (orientation){
    //         case Orientation.EAST : {
    //             portArray[0].set_xPosition(xPosition - width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         case Orientation.NORTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition + height / 2);
    //         };
    //         case Orientation.SOUTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition - height / 2);
    //         };
    //         case Orientation.WEST : {
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
    // override public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>{
    //     switch (orientation){
    //         case Orientation.EAST : {
    //             portArray[0].set_xPosition(xPosition + width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         case Orientation.NORTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition - height / 2);
    //         };
    //         case Orientation.SOUTH : {
    //             portArray[0].set_xPosition(xPosition);
    //             portArray[0].set_yPosition(yPosition + height / 2);
    //         };
    //         case Orientation.WEST : {
    //             portArray[0].set_xPosition(xPosition - width / 2);
    //             portArray[0].set_yPosition(yPosition);
    //         };
    //         default : {
    //             //do nothing
    //         }
    //     }
    //     return portArray;
    // }

    public function createPorts( component : Component ) : Void {

        var port = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        port.set_portDescription( IOTYPE.OUTPUT ) ;
        component.addPort( port ) ;
    }
    
    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool, selection : SelectionModel){
        DrawComponent.drawConnector(component, drawingAdapter, highlight) ;
    }
}
