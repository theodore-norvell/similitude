package model.component;
import model.observe.*;
import type.Coordinate ;

/**
 *  A circuit element that can be connected to other circuit elements with
 * which it shares a common location.
 */
class Connectable extends CircuitElement implements Observer {


    // Invariant. connection is never null and always contains
    // at least this connectable. 
    var connection : Connection ;

    public function new(cd : CircuitDiagramI, x:Float, y:Float) {
        super(cd) ;
        var coordinate = new Coordinate( x, y ) ;
        this.connection = new Connection( cd, coordinate, this ) ;
        this.connection.addObserver( this ) ;
    }

    public function isPort() { return false ; }
    
    public function update( target: ObservableI,?data: Any) : Void {
        notifyObservers( this ) ;
    }

    // Call back: Should only be called from the connection.
    @:allow(model.component.Connection)
    private function setConnection( connection : Connection ) {
        this.connection = connection ;
    }

    public function disconnect( ) : Void {
        if( isConnected() ) {
            this.connection.disconnect( this ) ;
            notifyObservers( this ) ; }
    }

    /**
     * Connect this connectable to another connectable.
     * This object will lose any of its present connections.
     * @param other 
     */
    public function connectTo( other : Connectable ) : Void {
        other.connection.connect( this ) ;
        notifyObservers( this ) ;
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