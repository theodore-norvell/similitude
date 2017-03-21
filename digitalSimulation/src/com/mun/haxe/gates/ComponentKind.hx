package com.mun.haxe.gates;

import com.mun.haxe.component.Port;
interface ComponentKind {

    /**
    * get the gate delay
    **/
    public function getDelay() : Int;

    /**
    * set the gate delay
    **/
    public function setDelay(delay : Int) : Void;

    /**
	 * Every gate should have a algorithm to define the output value.
	 * this method is to calculate the gate value.
	 * @param new type to manage those input and output
	 * @return new type describe those input and output
	 */
    public function algorithm(portArray : Array<Port>) : Array<Port>;
}
