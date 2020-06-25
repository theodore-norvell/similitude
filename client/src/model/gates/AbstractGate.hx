package model.gates;

import assertions.Assert ;
import type.Coordinate;
import model.attribute.* ;
import model.component.* ;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;

 /**
  * A parent class for gates and gate-like things.
  * An abstract gate has at least 2 ports.
  * In East orientation, port 0 is on the right and 
  * all others are on the left.
  */
class AbstractGate extends AbstractComponentKind {

    public function new( nameOfKind : String ) {
        super( nameOfKind ) ;
        attributes.add( StandardAttributes.numberOfInputPorts ) ;
        attributes.add( StandardAttributes.delay ) ;
    }

    function initialNumberOfInPorts() : Int { return 2 ; }
    function minimumNumberOfInPorts() : Int { return 2 ; }

    function maximumNumberOfInPorts() : Int { return 10 ; }
    
    public function createPorts( component : Component ) : Void {
        var value = new IntegerAttributeValue( initialNumberOfInPorts() ) ;
        update( component, StandardAttributes.numberOfInputPorts, value ) ;
    }
    function setTheNumberOfPortsTo( component : Component, count : Int ) {
        var currentCount = component.get_portCount() ;
        while( currentCount > count ) {
                component.removePort() ;
                currentCount -= 1 ; }

        if( currentCount == 0 && count > 0 ) {
            var port = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
            port.set_portDescription( IOTYPE.OUTPUT ) ;
            component.addPort( port ) ;
            currentCount = 1 ; }

        while( currentCount < count ) {
            var port = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
            port.set_portDescription( IOTYPE.INPUT ) ;
            component.addPort( port ) ;
            currentCount += 1 ;
        }
    }

    override public function canUpdateUntyped( component : Component, attribute : AttributeUntyped, value : AttributeValue ) : Bool {
        if( ! super.canUpdateUntyped( component, attribute, value) ) return false ;

        if( attribute == StandardAttributes.numberOfInputPorts ) {
            // The cast on the next lines is safe because the type of value has
            // been checked above in the super call.
            var val = cast( value, IntegerAttributeValue ) ;
            var intVal = val.getValue() ;
            return intVal >= minimumNumberOfInPorts() && intVal <= maximumNumberOfInPorts() ;
        } else {
            return true ; }
        Assert.assert( attribute.getType() == value.getType() ) ;
        return component.attributeValueList.has( attribute ) ;
    }
    override public function updateUntyped( component : Component, attribute : AttributeUntyped, value : AttributeValue ) : Void {
        Assert.assert( canUpdateUntyped( component, attribute, value ) ) ;
        if( attribute == StandardAttributes.numberOfInputPorts ) {
            // The cast on the next lines is safe because the type of value has
            // been checkeda bove in precondition check.
            var val = cast( value, IntegerAttributeValue ) ;
            var intVal = val.getValue() ;
            setTheNumberOfPortsTo( component, 1 + intVal ) ;
            updatePortPositions( component ) ;
        }
        super.updateUntyped( component, attribute, value ) ;
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
