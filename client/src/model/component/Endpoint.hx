package model.component;

import js.html.svg.CircleElement;


/**
 * Every link should have two endpoints
 * @author wanhui
 *
 */
class Endpoint extends CircuitElement {
    var xPosition:Float;
    var yPosition:Float;
    var port:Port;

    /**
	 * constructor for the endpont
	 * @param xPosition x position
	 * @param yPosition y position
	 */
    public function new(cd : CircuitDiagramI, xPosition:Float, yPosition:Float) {
        super(cd) ;
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.port = null ;
    }

    public function get_xPosition():Float {
        return xPosition;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function get_port():Port {
        return port;
    }

    public function set_xPosition(value:Float) : Void {
        this.xPosition = value;
        notifyObservers(this) ;
    }

    public function set_yPosition(value:Float): Void {
        this.yPosition = value;
        notifyObservers(this) ;
    }

    public function set_port(value:Port) : Void {
        this.port = value;
        notifyObservers(this) ;
    }

    public function updatePosition() : Void {
        if(port != null){
            xPosition = port.get_xPosition();
            yPosition = port.get_yPosition();
            notifyObservers(this) ;
        }
    }
}
