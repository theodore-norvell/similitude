package model.gates;

import assertions.Assert ;
import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.drawComponents.DrawFlipFlop;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
import model.selectionModel.SelectionModel ;
/**
 * Flip-Flop<br>
 * Truth Table
 * <br>
 * <pre>
 * ****************************************
 * *|   CLK  |    D   |    Q   |    QN   |*<br>
 * *|    0   |    0   |    Q   |    QN   |*<br>
 * *|    0   |    1   |    Q   |    QN   |*<br>
 * *|    1   |    0   |    0   |    1    |*<br>
 * *|    1   |    1   |    1   |    0    |*<br>
 * ****************************************
 *  </pre>
 * @author wanhui
 *
 */
class FlipFlop implements ComponentKind extends AbstractComponentKind implements ComponentKind {

    public function new() {
        super( "FlipFlop");
        // TODO Add attributes.
    }

    // public function createPorts():Array<Port> {
    //     var portArray:Array<Port> = new Array<Port>();
    //     //flip-flop have an input inport and one clock inport
    //     switch (orientation){
    //         case Orientation.EAST : {
    //             //inport
    //             var inport_D:Port = new Port(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
    //             inport_D.set_portDescription(IOTYPE.D);
    //             portArray.push(inport_D);
    //             var inport_CLK:Port = new Port(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
    //             inport_CLK.set_portDescription(IOTYPE.CLK);
    //             portArray.push(inport_CLK);
    //             //outport
    //             var outport_Q:Port = new Port(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
    //             outport_Q.set_portDescription(IOTYPE.Q);
    //             portArray.push(outport_Q);
    //             var outport_QN:Port = new Port(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
    //             outport_QN.set_portDescription(IOTYPE.QN);
    //             portArray.push(outport_QN);
    //         };
    //         case Orientation.WEST : {
    //             //inport
    //             var inport_D:Port = new Port(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
    //             inport_D.set_portDescription(IOTYPE.D);
    //             portArray.push(inport_D);
    //             var inport_CLK:Port = new Port(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
    //             inport_CLK.set_portDescription(IOTYPE.CLK);
    //             portArray.push(inport_CLK);
    //             //outport
    //             var outport_Q:Port = new Port(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
    //             outport_Q.set_portDescription(IOTYPE.Q);
    //             portArray.push(outport_Q);
    //             var outport_QN:Port = new Port(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
    //             outport_QN.set_portDescription(IOTYPE.QN);
    //             portArray.push(outport_QN);
    //         };
    //         case Orientation.SOUTH : {
    //             //inport
    //             var inport_D:Port = new Port(xPosition - width / 2 + width / 3 * 1, yPosition - height / 2);
    //             inport_D.set_portDescription(IOTYPE.D);
    //             portArray.push(inport_D);
    //             var inport_CLK:Port = new Port(xPosition - width / 2 + width / 3 * 2, yPosition - height / 2);
    //             inport_CLK.set_portDescription(IOTYPE.CLK);
    //             portArray.push(inport_CLK);
    //             //outport
    //             var outport_Q:Port = new Port(xPosition - width / 2 + width / 3 * 1, yPosition + height / 2);
    //             outport_Q.set_portDescription(IOTYPE.Q);
    //             portArray.push(outport_Q);
    //             var outport_QN:Port = new Port(xPosition - width / 2 + width / 3 * 2, yPosition + height / 2);
    //             outport_QN.set_portDescription(IOTYPE.QN);
    //             portArray.push(outport_QN);
    //         };
    //         case Orientation.NORTH : {
    //             //inport
    //             var inport_D:Port = new Port(xPosition - width / 2 + width / 3 * 1, yPosition + height / 2);
    //             inport_D.set_portDescription(IOTYPE.D);
    //             portArray.push(inport_D);
    //             var inport_CLK:Port = new Port(xPosition - width / 2 + width / 3 * 2, yPosition + height / 2);
    //             inport_CLK.set_portDescription(IOTYPE.CLK);
    //             portArray.push(inport_CLK);
    //             //outport
    //             var outport_Q:Port = new Port(xPosition - width / 2 + width / 3 * 1, yPosition - height / 2);
    //             outport_Q.set_portDescription(IOTYPE.Q);
    //             portArray.push(outport_Q);
    //             var outport_QN:Port = new Port(xPosition - width / 2 + width / 3 * 2, yPosition - height / 2);
    //             outport_QN.set_portDescription(IOTYPE.QN);
    //             portArray.push(outport_QN);
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
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.D){
    //                     portArray[i].set_xPosition(xPosition - width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.CLK){
    //                     portArray[i].set_xPosition(xPosition - width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
    //                 }
    //             }
    //         };
    //         case Orientation.WEST : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.D){
    //                     portArray[i].set_xPosition(xPosition + width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.CLK){
    //                     portArray[i].set_xPosition(xPosition + width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
    //                 }
    //             }
    //         };
    //         case Orientation.SOUTH : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.D){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
    //                     portArray[i].set_yPosition(yPosition - height / 2);
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.CLK){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
    //                     portArray[i].set_yPosition(yPosition - height / 2);
    //                 }
    //             }
    //         };
    //         case Orientation.NORTH : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.D){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
    //                     portArray[i].set_yPosition(yPosition + height / 2);
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.CLK){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
    //                     portArray[i].set_yPosition(yPosition + height / 2);
    //                 }
    //             }
    //         };
    //         default : {
    //             //do nothing
    //         }
    //     }
    //     return portArray;
    // }
    /**
    * different from others, this function used in move command when the componenet has been re-located
    **/
    // override public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>{
    //     switch (orientation){
    //         case Orientation.EAST : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.Q){
    //                     portArray[i].set_xPosition(xPosition + width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.QN){
    //                     portArray[i].set_xPosition(xPosition + width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
    //                 }
    //             }
    //         };
    //         case Orientation.WEST : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.Q){
    //                     portArray[i].set_xPosition(xPosition - width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.QN){
    //                     portArray[i].set_xPosition(xPosition - width / 2);
    //                     portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
    //                 }
    //             }
    //         };
    //         case Orientation.SOUTH : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.Q){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
    //                     portArray[i].set_yPosition(yPosition + height / 2);
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.QN){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
    //                     portArray[i].set_yPosition(yPosition + height / 2);
    //                 }
    //             }
    //         };
    //         case Orientation.NORTH : {
    //             for(i in 0...portArray.length){
    //                 if(portArray[i].get_portDescription() == IOTYPE.Q){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
    //                     portArray[i].set_yPosition(yPosition - height / 2);
    //                 }

    //                 if(portArray[i].get_portDescription() == IOTYPE.QN){
    //                     portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
    //                     portArray[i].set_yPosition(yPosition - height / 2);
    //                 }
    //             }
    //         };
    //         default : {
    //             //do nothing
    //         }
    //     }
    //     return portArray;
    // }

    public function createPorts( component : Component ) : Void {

        var q = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        q.set_portDescription( IOTYPE.OUTPUT ) ;
        component.addPort( q ) ;

        var d = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        d.set_portDescription( IOTYPE.INPUT ) ;
        component.addPort( d ) ;
        
        var clk = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        clk.set_portDescription( IOTYPE.CLK ) ;
        component.addPort( clk ) ;
    }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool, selection : SelectionModel){
        var drawComponent:DrawFlipFlop = new DrawFlipFlop(component, drawingAdapter, highlight);
        drawComponent.drawCorrespondingComponent() ;
    }
}
