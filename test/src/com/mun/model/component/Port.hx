package com.mun.model.component;


import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.ValueLogic;
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

    /** get the logic value of this port
    *
    **/
    public function get_value():ValueLogic;

    /** set the logic value
    *
    **/
    public function set_value(value:ValueLogic):Void;

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
}
