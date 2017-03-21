package com.mun.haxe.gates;
import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.component.Port;

/**
 * NOR gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    0   |*<br>
 * *|   0    |    1    |    0   |*<br>
 * *|   1    |    0    |    0   |*<br>
 * *|   0    |    0    |    1   |*<br>
 * *******************************
 *  </pre>
 * @author wanhui
 *
 */
class NOR implements ComponentKind{
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
            if(port.get_portDescription() == IOTYPE.INPUT && port.get_value() == ValueLogic.TRUE){
                value = ValueLogic.FALSE;
                break;
            }
        }

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.OUTPUT){
                portArray.remove(port);
                port.set_value(value);
                portArray.push(port);
            }
        }
        return portArray;
    }

    public function new() {
    }
}
