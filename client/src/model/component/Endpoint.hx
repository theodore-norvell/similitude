package model.component;

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
