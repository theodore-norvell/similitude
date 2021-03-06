package model.component;

import assertions.Assert ;
import type.Coordinate;

/**
 * A Connection is a mutable collection of Connectable elements
 * and a shared, mutable location that is shared by them all.
 */
class Connection extends CircuitElement {
    // This is the location of the connection.
    // It is shared by everything connected by this connection.
    var coordinate : Coordinate ;

    // Invariant. Items of connectedElements are unique. At most one is a Port.
    var connectedElements : Array<Connectable> = new Array<Connectable>() ;

    public function new(cd : CircuitDiagramI, coordinate : Coordinate, connectable : Connectable ) {
        super( cd ) ;
        this.coordinate = coordinate ;
        connectedElements.push( connectable ) ;
    }

    public function toString() : String {
        return "Connection( x:" + coordinate.get_xPosition()
                         + " y:" + coordinate.get_yPosition() 
                         + " len: " + connectedElements.length + ")" ;
    }


    public function location() : Coordinate {
        return coordinate ;
    }

    public function get_xPosition() : Float {
        return coordinate.get_xPosition() ;
    }

    public function get_yPosition() : Float {
        return coordinate.get_yPosition() ;
    }

    public function moveTo( coordinate : Coordinate ) {
        this.coordinate = coordinate ;
        notifyObservers( this ) ;
    }

    public function connect( connectable : Connectable ) : Void {
        Assert.assert( connectable.get_CircuitDiagram() == this.get_CircuitDiagram() ) ;
        if( connectedElements.indexOf( connectable ) == -1 ) {
            if( ! connectable.isPort() || ! aPortIsConnected() ) {
                var oldConnection = connectable.getConnection() ;
                oldConnection.connectedElements.remove( connectable ) ;
                connectable.setConnection( this ) ;
                connectedElements.push( connectable ) ;
                notifyObservers( this ) ; } }
    }

    public function aPortIsConnected() {
        for( c in connectedElements ) if( c.isPort() ) return true ;
        return false ;
    }
    public function disconnect( connectable : Connectable ) {
        if( connectedElements.indexOf( connectable ) != -1 ) {
            connectable.setConnection( new Connection( this.get_CircuitDiagram(), this.coordinate, connectable ) ) ;
            connectedElements.remove( connectable ) ;
            notifyObservers( this ) ; }
    }

    public function get_count() : Int {
        return connectedElements.length ;
    }
    
    public function get_connectedElements() : Iterator<Connectable> {
        return connectedElements.iterator()  ;
    }
}