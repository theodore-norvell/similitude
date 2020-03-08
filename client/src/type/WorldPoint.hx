package type;
/**
* typedef WorldPoint = {
    var circuitDiagram:CircuitDiagram;
    var coordinate:Coordinate;
}
**/
import model.component.CircuitDiagram;
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

    public function set_circuitDiagram(value:CircuitDiagram) {
        return this.circuitDiagram = value;
    }

    public function get_coordinate():Coordinate {
        return coordinate;
    }

    public function set_coordinate(value:Coordinate) {
        return this.coordinate = value;
    }
}
