package com.mun.haxe.gates;
import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.component.Port;
/**
 * output<br>
 * the output result is the same as input
 * @author wanhui
 *
 */
class Output implements ComponentKind{
    var delay : Int = 0;//init is zero
    @:isVar var sequence(get, set):Int;//init is 1

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

    function get_sequence():Int {
        return sequence;
    }

    function set_sequence(value:Int) {
        return this.sequence = value;
    }

    public function new() {
    }
}
