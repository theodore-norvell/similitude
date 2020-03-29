package type;
import model.component.CircuitDiagram;

/**
 *  A World Point is a pair consisting of a world coordinate and 
 *  a circuit diagram whose origin that that point is relative to.
 */
class WorldPoint {
    var circuitDiagram:CircuitDiagram;
    var coordinate:Coordinate;

    public function new(circuitDiagram:CircuitDiagram, coordinate:Coordinate) {
        this.circuitDiagram = circuitDiagram;
        this.coordinate = coordinate;
    }

    public function get_circuitDiagram():CircuitDiagram {
        return circuitDiagram;
    }

    public function get_coordinate():Coordinate {
        return coordinate;
    }
}
