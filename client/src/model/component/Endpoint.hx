package model.component;

import js.html.svg.CircleElement;


/**
 * Every link should have two endpoints
 * @author wanhui
 *
 */
class Endpoint extends Connectable  {

    /**
	 * constructor for the endpont
	 * @param xPosition x position
	 * @param yPosition y position
	 */
    public function new(cd : CircuitDiagramI, x:Float, y:Float) {
        super(cd, x, y) ;
    }
}
