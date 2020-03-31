package model.component;


import model.enumeration.IOTYPE;
/**
 * Every gate should have port to access the logic value
 * @author wanhui
 *
 */
class Port extends Connectable {

    var sequence:Int = -1;
    var description : IOTYPE ;

    public function new(cd : CircuitDiagram, x:Float, y:Float) {
        super(cd, x, y) ;
        this.description = IOTYPE.OUTPUT ; 
    }

    public function isPort() { return true ; }

    public function get_sequence():Int {
        return this.sequence;
    }

    public function set_sequence(sequence:Int):Void {
        this.sequence = sequence;
    }

    public function get_portDescription():IOTYPE {
        return this.description ;
    }

    public function set_portDescription(description:IOTYPE):Void {
        this.description = description;
    }
}