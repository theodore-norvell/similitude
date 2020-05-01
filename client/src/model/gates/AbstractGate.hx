package model.gates;

import type.Coordinate;
import model.drawComponents.DrawAND;
import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.selectionModel.SelectionModel ;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
 /**
  * A parent class for gates and gate-like things.
  * 
  */
class AbstractGate extends AbstractComponentKind {

    public function new() {
        super() ;
        // TODO Add attributes
    }

    function initialNumberOfInPorts() : Int { return 2 ; }
    override public function createPorts( component : Component, addPort : Port -> Void ) : Void {
        var port = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        port.set_portDescription( IOTYPE.OUTPUT ) ;
        addPort( port ) ;
        for( i in 0 ... initialNumberOfInPorts() ) {
            port = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
            port.set_portDescription( IOTYPE.INPUT ) ;
            addPort( port ) ;
        }
    }

    override public function updatePortPositions( component : Component  ) : Void {
        //TODO: Deal with other orientations
        var inputs = component.get_portCount() - 1 ;
        var output_coord = new Coordinate( component.right(), component.get_yPosition() ) ;
        var prev_input_coord = new Coordinate( component.left(), component.top() ) ;
        var input_delta = new Coordinate( 0, component.get_height() / (inputs+1)  ) ;
        for( port in component.get_ports() ) {
            if( port.get_portDescription() == IOTYPE.INPUT ) {
                prev_input_coord = prev_input_coord.plus( input_delta ) ;
                port.moveTo( prev_input_coord ) ;
            } else if( port.get_portDescription() == IOTYPE.OUTPUT ) {
                port.moveTo( output_coord ) ;
            }
        }
    }
}
