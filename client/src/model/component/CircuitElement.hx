package model.component;

import model.observe.Observable;
import type.Coordinate;
import assertions.Assert;

/**
 * Circuits elements comprise components, links, and end-points.
 *
 */
class CircuitElement extends Observable {

    var cd : CircuitDiagram ;

    public function new( cd : CircuitDiagramI ) {
        //super() ;
        this.cd = cast( cd, CircuitDiagram ) ;
        this.addObserver( this.cd ) ;
    }

    public function left() : Float { Assert.assert(false) ; return 0 ;}

    public function right() : Float { Assert.assert(false) ; return 0 ; }

    public function top() : Float { Assert.assert(false) ; return 0 ; }

    public function bottom() : Float { Assert.assert(false) ; return 0 ; }

    public function get_CircuitDiagram() : CircuitDiagram { return this.cd ; }
}