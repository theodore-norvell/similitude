import buddy.* ;
using buddy.Should;

import assertions.Assert ;
import model.component.* ;
import model.gates.* ;
import model.enumeration.Orientation ;

class TestCircuitDiagram extends SingleSuite {
    public function new() {
        // A test suite:
        describe("CircuitDiagram", {
            var cd : CircuitDiagramI ;
            var observer = new MockObserver() ;

            beforeEach({
                cd = new CircuitDiagram() ;
                observer = new MockObserver() ;
                cd.addObserver( observer ) ;
            });

            it("should be constructed", {
                var comps = cd.get_componentIterator() ;
                comps.hasNext().should.be( false ) ;

                var links = cd.get_linkIterator() ;
                links.hasNext().should.be( false ) ;

                var w = cd.get_diagramWidth() ;
                (w).should.beGreaterThan(0.0) ;
                (w).should.beLessThan( Math.POSITIVE_INFINITY ) ;

                var h = cd.get_diagramHeight() ;
                h.should.beGreaterThan(0.0) ;
                h.should.beLessThan( Math.POSITIVE_INFINITY ) ;

                cd.checkInvariant() ;
            });



            it("should be possible to make and add a component", {
                var kind = new XOR() ;
                var comp = new Component( cd, 100, 100, 20, 20, Orientation.EAST, kind ) ;
                comp.get_CircuitDiagram().should.be(cd) ;
                comp.addObserver( observer ) ;

                cd.addComponent( comp ) ;
                var comps = cd.get_componentIterator() ;
                comps.hasNext().should.be( true ) ;
                var c = comps.next() ;
                c.should.be(comp) ;
                observer.count( comp ).should.be( 0 ) ;
                observer.count( cd ).should.be( 1 ) ;
                cd.checkInvariant() ;
            });

            afterEach({
            });
        });
        
    }
}