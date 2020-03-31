package model.component;
import type.Coordinate ;

class Connectable extends CircuitElement {

    var connection : Connection ;

    public function new(cd : CircuitDiagramI, x:Float, y:Float) {
        super(cd) ;
        var coordinate = new Coordinate( x, y ) ;
        this.connection = new Connection( cd, coordinate, this ) ;
    }

    // Call back: Should only be called from the connection.
    @:allow(model.component.Connection)
    private function setConnection( connection : Connection ) {
        this.connection = connection ;
    }

    public function disconnect( ) : Void {
        if( isConnected() ) this.connection.disconnect( this ) ;
    }

    /**
     * Connect this connectable to another connectable.
     * This object will lose any of its present connections.
     * @param other 
     */
    public function connectTo( other : Connectable ) : Void {
        other.connection.connect( this ) ;
    }

    public function isConnected( ) : Bool {
        return this.connection.get_count() > 1 ;
    }

    public function get_xPosition() : Float {
        return connection.get_xPosition() ;
    }

    public function get_yPosition() : Float {
        return connection.get_yPosition() ;
    }

    public function moveTo( coordinate : Coordinate ) {
        this.connection.moveTo( coordinate) ;
        notifyObservers( this ) ;
    }
}