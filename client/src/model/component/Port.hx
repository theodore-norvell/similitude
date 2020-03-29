package model.component;


import model.enumeration.IOTYPE;
/**
 * Every gate should have port to access the logic value
 * @author wanhui
 *
 */
interface Port {
    /** get the x position of this port
    *
    **/
    public function get_xPosition():Float;

    /** get the y position of this port
    *
    **/
    public function get_yPosition():Float;

    /** set the x position of this port
    *
    **/
    public function set_xPosition(xPosition:Float):Void;

    /** set the y position of this port
    *
    **/
    public function set_yPosition(yPosition:Float):Void;

    /** get the port description, Inport or outport
    *
    **/
    public function get_portDescription():IOTYPE;

    /** get the port description, Inport or outport
    *
    **/
    public function set_portDescription(value:IOTYPE):Void;

    /** get the sequence of this port
    *
    **/
    public function get_sequence():Int;

    /** set the sequence of this port
    *
    **/
    public function set_sequence(sequence:Int):Void;

    public function createJSon():String;
}
