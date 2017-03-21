package com.mun.haxe.gates;

import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.component.Port;
import com.mun.haxe.enumeration.IOTYPE;

/**
 * input<br>
 * the output is the same as input
 * @author wanhui
 *
 */
class Input implements ComponentKind{
    @:isVar var sequence(get, set):Int;//the sequence of the input order in the diagram, the initial value is 1
    var delay : Int = 0;//init is zero

    public function getDelay():Int {
        return delay;
    }

    public function setDelay(delay:Int):Void {
        this.delay = delay;
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port : Port;
        var value : ValueLogic = ValueLogic.TRUE;

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.INPUT){//for input gate there should be have only one input port and also only one output port
                value = port.get_value();
                break;
            }
        }
        for(port in portArray){
            if(port.get_portDescription == IOTYPE.OUTPUT){
                portArray.remove(portArray);
                port.set_value(value);
                portArray.push(port);
            }
        }

        return portArray;
    }

    public function new() {

    }

    function get_sequence():Int {
        return sequence;
    }

    function set_sequence(value:Int) {
        return this.sequence = value;
    }


}
