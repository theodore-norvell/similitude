import buddy.* ;
using buddy.Should;

import assertions.Assert ;
import model.component.* ;
import model.gates.* ;
import model.enumeration.MODE;
import model.enumeration.Orientation ;
import type.Coordinate;
import type.HitObject ;

class TestFindHits extends SingleSuite {
    public function new() {
        // A test suite:
        describe("HitList", {
            var cd : CircuitDiagramI ;

            beforeEach({
                cd = new CircuitDiagram() ;
            });

            it("should find components and ports", {
                var kind = new XOR() ;
                var comp0 = new Component( cd, 100, 200, 40, 40, Orientation.EAST, kind ) ;
                cd.addComponent( comp0 ) ;

                var outPort0 = comp0.get_ports().next() ;
                // Check that it is where I think it should be.
                outPort0.get_xPosition().should.be( 120 ) ;
                outPort0.get_yPosition().should.be( 200 ) ;

                var comp1 = new Component( cd, 120, 220, 40, 40, Orientation.EAST, kind ) ;
                cd.addComponent( comp1 ) ;
                cd.checkInvariant() ;

                { // Hit comp 0
                    var hits = cd.findHitList( new Coordinate( 90, 190), MODE.INCLUDE_PARENTS ) ;
                    hits.length.should.be( 1 ) ;
                    var h0 = hits[0] ;
                    var c0 = h0.get_component() ;
                    c0.should.be(comp0) ;
                }

                {  // Hit both components 
                    var hits = cd.findHitList( new Coordinate( 110, 210 ), MODE.INCLUDE_PARENTS ) ;
                    hits.length.should.be( 2 ) ;
                    var h0 = hits[0] ;
                    var h1 = hits[1] ;
                    var c0 = h0.get_component() ;
                    var c1 = h1.get_component() ;
                    if( c0 == comp0 ) {
                        c1.should.be( comp1 ) ;
                    } else {
                        c0.should.be( comp1 ) ;
                        c1.should.be( comp0 ) ;
                    }
                }

                {   // Hit both components and the output port of comp 1.
                    // Here we miss the port by a distance of (-1,+1). It should still hit.
                    var hits = cd.findHitList( new Coordinate( 119, 201 ), MODE.INCLUDE_PARENTS ) ;
                    hits.length.should.be( 3 ) ;

                    var ports = new Array<Port>() ;
                    var comps = new Array<Component>() ;
                    for( h in hits ) {
                        if( h.get_component() != null ) comps.push( h.get_component() ) ;
                        if( h.get_port() != null ) ports.push( h.get_port() ) ;
                    }

                    ports.length.should.be(1) ;
                    // Check it is the out port of the first gate.
                    ports[0].should.be( outPort0 ) ;


                    comps.length.should.be(2) ;
                    if( comps[0] == comp0 ) {
                        comps[1].should.be( comp1 ) ;
                    } else {
                        comps[0].should.be( comp1 ) ;
                        comps[1].should.be( comp0 ) ;
                    }
                }


            });

            afterEach({
            });
        });
        
    }
}