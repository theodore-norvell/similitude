import buddy.* ;
using buddy.Should;

import assertions.Assert ;
import model.attribute.* ;
import model.component.* ;
import model.gates.* ;
import model.enumeration.MODE;
import model.enumeration.Orientation ;
import type.Coordinate;
import type.HitObject ;
import type.TimeUnit ;

class TestAttributeChanges extends SingleSuite {
    public function new() {
        // A test suite:
        describe("Attributes", {
            var cd : CircuitDiagramI ;

            beforeEach({
                cd = new CircuitDiagram() ;
            });

            it("should be possible to rotate a component via the either interface", {
                var kind = new XOR() ;
                var comp0 = new Component( cd, 100, 200, 40, 30, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;

                cd.checkInvariant() ;

                //trace( "comp0 is " + comp0) ;

                var attr = StandardAttributes.orientation ;
                var south = new OrientationAttributeValue( Orientation.SOUTH ) ;
                var east = new OrientationAttributeValue( Orientation.EAST ) ;
                var west = new OrientationAttributeValue( Orientation.WEST ) ;
                var north = new OrientationAttributeValue( Orientation.NORTH ) ;
                // Change using the set_orientation method
                {
                    comp0.set_orientation( Orientation.WEST ) ;

                    var actualOrientation = comp0.get_orientation() ;
                    (actualOrientation == Orientation.WEST).should.be( true ) ;

                    var actualOrientationAttributeValue = comp0.get( attr ) ;
                    (  actualOrientationAttributeValue.getOrientation()
                    == Orientation.WEST ).should.be( true ) ;

                    var actualAttributeValue = comp0.getUntyped( attr ) ;
                    actualOrientationAttributeValue = cast(actualAttributeValue, OrientationAttributeValue) ;
                    (  actualOrientationAttributeValue.getOrientation()
                    == Orientation.WEST ).should.be( true ) ;
                }
                // Change using the untyped interface
                {
                    var ok = comp0.canUpdate( attr, south  ) ;
                    ok.should.be( true ) ;

                    comp0.updateAttribute( attr, south ) ;

                    var actualOrientation = comp0.get_orientation() ;
                    (actualOrientation == Orientation.SOUTH).should.be( true ) ;

                    var actualOrientationAttributeValue = comp0.get( attr ) ;
                    actualOrientationAttributeValue.should.be( south ) ;

                    var actualAttributeValue = comp0.getUntyped( attr ) ;
                    actualAttributeValue.should.be( south ) ;
                }
                // Change using the untyped interface
                {
                    var ok = comp0.canUpdateUntyped( attr, north  ) ;
                    ok.should.be( true ) ;

                    comp0.updateUntyped( attr, north ) ;

                    var actualOrientation = comp0.get_orientation() ;
                    (actualOrientation == Orientation.NORTH).should.be( true ) ;

                    var actualOrientationAttributeValue = comp0.get( attr ) ;
                    actualOrientationAttributeValue.should.be( north ) ;

                    var actualAttributeValue = comp0.getUntyped( attr ) ;
                    actualAttributeValue.should.be( north ) ;
                }
            }) ;

            it("should move ports should with rotation", {
                var kind = new XOR() ;
                var comp0 = new Component( cd, 100, 200, 40, 30, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;
                cd.checkInvariant() ;

                trace( "comp0 is " + comp0) ;

                var portsIterator = comp0.get_ports() ;
                var port0 = portsIterator.next() ;
                var port1 = portsIterator.next() ;
                var port2 = portsIterator.next() ;
                // Check that it is where I think it should be.
                port0.get_xPosition().should.be( 120 ) ;
                port0.get_yPosition().should.be( 200 ) ;
                port1.get_xPosition().should.be( 80 ) ;
                port1.get_yPosition().should.be( 195 ) ;
                port2.get_xPosition().should.be( 80 ) ;
                port2.get_yPosition().should.be( 205 ) ;

                var attr = StandardAttributes.orientation ;
                var south = new OrientationAttributeValue( Orientation.SOUTH ) ;
                var east = new OrientationAttributeValue( Orientation.EAST ) ;
                var west = new OrientationAttributeValue( Orientation.WEST ) ;
                var north = new OrientationAttributeValue( Orientation.NORTH ) ;
                // Change to south
                {
                    var ok = comp0.canUpdate( attr, south  ) ;
                    ok.should.be( true ) ;

                    comp0.updateAttribute( attr, south ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 100 ) ;
                    port0.get_yPosition().should.be( 210 ) ;
                    port1.get_xPosition().should.be( 105 ) ;
                    port1.get_yPosition().should.be( 180 ) ;
                    port2.get_xPosition().should.be(  95 ) ;
                    port2.get_yPosition().should.be( 180 ) ;
                    
                }
                // Change to west
                {
                    var ok = comp0.canUpdate( attr, west  ) ;
                    ok.should.be( true ) ;

                    comp0.updateAttribute( attr, west ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be(  80 ) ;
                    port0.get_yPosition().should.be( 210 ) ;
                    port1.get_xPosition().should.be( 120 ) ;
                    port1.get_yPosition().should.be( 205 ) ;
                    port2.get_xPosition().should.be( 120 ) ;
                    port2.get_yPosition().should.be( 195 ) ;
                    
                }
                // Change to north
                {
                    var ok = comp0.canUpdate( attr, north  ) ;
                    ok.should.be( true ) ;

                    comp0.updateAttribute( attr, north ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 100 ) ;
                    port0.get_yPosition().should.be( 180 ) ;
                    port1.get_xPosition().should.be(  95 ) ;
                    port1.get_yPosition().should.be( 220 ) ;
                    port2.get_xPosition().should.be( 105 ) ;
                    port2.get_yPosition().should.be( 220 ) ;
                }
                // Change to east
                {
                    var ok = comp0.canUpdate( attr, east  ) ;
                    ok.should.be( true ) ;

                    comp0.updateAttribute( attr, east ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 120 ) ;
                    port0.get_yPosition().should.be( 200 ) ;
                    port1.get_xPosition().should.be( 80 ) ;
                    port1.get_yPosition().should.be( 195 ) ;
                    port2.get_xPosition().should.be( 80 ) ;
                    port2.get_yPosition().should.be( 205 ) ;
                }
            });

            it("should be possible add and remove ports", {
                var kind = new AND() ;
                var comp0 = new Component( cd, 100, 200, 40, 60, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;

                cd.checkInvariant() ;

                var attr = StandardAttributes.numberOfInputPorts ;
                {
                    //trace( "comp0 is " + comp0 ) ;
                    comp0.get_portCount().should.be( 3 ) ;
                    var portsIterator = comp0.get_ports() ;
                    var port0 = portsIterator.next() ;
                    var port1 = portsIterator.next() ;
                    var port2 = portsIterator.next() ;
                    portsIterator.hasNext().should.be( false ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 120 ) ;
                    port0.get_yPosition().should.be( 200 ) ;
                    port1.get_xPosition().should.be( 80 ) ;
                    port1.get_yPosition().should.be( 190 ) ;
                    port2.get_xPosition().should.be( 80 ) ;
                    port2.get_yPosition().should.be( 210 ) ;
                }
                // Make it 3 input ports
                {
                    var val = new IntegerAttributeValue( 3 ) ;
                    comp0.canUpdate( attr, val ).should.be( true ) ;
                    comp0.updateAttribute( attr, val ) ;
                    //trace( "comp0 is " + comp0 ) ;

                    comp0.get_portCount().should.be( 4 ) ;
                    var portsIterator = comp0.get_ports() ;
                    var port0 = portsIterator.next() ;
                    var port1 = portsIterator.next() ;
                    var port2 = portsIterator.next() ;
                    var port3 = portsIterator.next() ;
                    portsIterator.hasNext().should.be( false ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 120 ) ;
                    port0.get_yPosition().should.be( 200 ) ;
                    port1.get_xPosition().should.be( 80 ) ;
                    port1.get_yPosition().should.be( 200 - 15 ) ;
                    port2.get_xPosition().should.be( 80 ) ;
                    port2.get_yPosition().should.be( 200 + 0) ;
                    port3.get_xPosition().should.be( 80 ) ;
                    port3.get_yPosition().should.be( 200 + 15) ;
                }
                // Make it 4 input ports
                {
                    var val = new IntegerAttributeValue( 4 ) ;
                    comp0.canUpdate( attr, val ).should.be( true ) ;
                    comp0.updateAttribute( attr, val ) ;
                    //trace( "comp0 is " + comp0 ) ;

                    comp0.get_portCount().should.be( 5 ) ;
                    var portsIterator = comp0.get_ports() ;
                    var port0 = portsIterator.next() ;
                    var port1 = portsIterator.next() ;
                    var port2 = portsIterator.next() ;
                    var port3 = portsIterator.next() ;
                    var port4 = portsIterator.next() ;
                    portsIterator.hasNext().should.be( false ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 120 ) ;
                    port0.get_yPosition().should.be( 200 ) ;
                    port1.get_xPosition().should.be( 80 ) ;
                    port1.get_yPosition().should.be( 200 - 18 ) ;
                    port2.get_xPosition().should.be( 80 ) ;
                    port2.get_yPosition().should.be( 200 -6) ;
                    port3.get_xPosition().should.be( 80 ) ;
                    port3.get_yPosition().should.be( 200 + 6) ;
                    port4.get_xPosition().should.be( 80 ) ;
                    port4.get_yPosition().should.be( 200 + 18 ) ;
                }
                // Make it 1 input ports
                {
                    var val = new IntegerAttributeValue( 1 ) ;
                    comp0.canUpdate( attr, val ).should.be( false ) ;
                }
                // Back to 2
                {
                    var val = new IntegerAttributeValue( 2 ) ;
                    comp0.canUpdate( attr, val ).should.be( true ) ;
                    comp0.updateAttribute( attr, val ) ;
                    //trace( "comp0 is " + comp0 ) ;

                    comp0.get_portCount().should.be( 3 ) ;
                    var portsIterator = comp0.get_ports() ;
                    var port0 = portsIterator.next() ;
                    var port1 = portsIterator.next() ;
                    var port2 = portsIterator.next() ;
                    portsIterator.hasNext().should.be( false ) ;

                    // Check that it is where I think it should be.
                    port0.get_xPosition().should.be( 120 ) ;
                    port0.get_yPosition().should.be( 200 ) ;
                    port1.get_xPosition().should.be( 80 ) ;
                    port1.get_yPosition().should.be( 190 ) ;
                    port2.get_xPosition().should.be( 80 ) ;
                    port2.get_yPosition().should.be( 210 ) ;
                }
            }) ;

            it("should be possible to change the delay of a gate", {
                var kind = new AND() ;
                var comp0 = new Component( cd, 100, 200, 40, 60, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;

                cd.checkInvariant() ;

                var attr = StandardAttributes.delay ;
                var val = comp0.get( attr ) ;
                val.toString().should.be("1 ns") ;

                val = new TimeAttributeValue( 200, TimeUnit.MICRO_SECOND ) ;
                comp0.updateAttribute( attr, val ) ;
                val = comp0.get( attr ) ;
                val.toString().should.be("200 µs") ;
            }) ;

            it("The name should be set automatically", {
                var kind = new AND() ;
                var comp0 = new Component( cd, 100, 200, 40, 60, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;

                var comp1 = new Component( cd, 100, 200, 40, 60, Orientation.EAST, kind ) ;
                cd.addComponent( comp1 ) ;

                cd.checkInvariant() ;

                var attr = StandardAttributes.name ;
                var currentVal = comp0.get( attr ) ;
                currentVal.getValue().should.be( "AND0" ) ;

                currentVal = comp1.get( attr ) ;
                currentVal.getValue().should.be( "AND1" ) ;

                var newVal = new StringAttributeValue( "" ) ;
                comp1.canUpdate( attr, newVal).should.be( false ) ;

                newVal = new StringAttributeValue( "Fred" ) ;
                comp1.canUpdate( attr, newVal).should.be( true ) ;
                currentVal = comp1.get( attr ) ;
                currentVal.getValue().should.be( "AND1" ) ; // Didn't change it yet.

                comp1.updateAttribute( attr, newVal ) ; // Now change it to Fred
                currentVal = comp1.get( attr ) ;
                currentVal.getValue().should.be( "Fred" ) ;

                newVal = new StringAttributeValue( "AND0" ) ;
                comp1.canUpdate( attr, newVal).should.be( false ) ;
            }) ;

            it("should notify observers", {
                var kind = new XOR() ;
                var comp0 = new Component( cd, 100, 200, 40, 30, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;

                cd.checkInvariant() ;

                var circuitObserver = new MockObserver() ;
                cd.addObserver( circuitObserver ) ;

                var compObserver = new MockObserver() ;
                comp0.addObserver( compObserver ) ;

                var delay = StandardAttributes.delay ;
                var newValue = new TimeAttributeValue( 100, TimeUnit.PICO_SECOND ) ;
                comp0.updateAttribute( delay,newValue) ;

                circuitObserver.count( cd ).should.be( 1 ) ;
                compObserver.count( comp0 ).should.be( 1 ) ;

            }) ;

            afterEach({
            });
        });

    
    }
}