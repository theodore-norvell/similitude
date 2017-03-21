package com.mun.haxe.gates;
import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.component.Port;

/**
 * OR gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    1   |*<br>
 * *|   0    |    1    |    1   |*<br>
 * *|   1    |    0    |    1   |*<br>
 * *|   0    |    0    |    0   |*<br>
 * *******************************
 *  </pre>
 * @author wanhui
 *
 */
class OR implements ComponentKind {
    var delay : Int = 0;// init is zero

    public function setDelay(delay:Int):Void {
        this.delay = delay;
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port : Port;
        var value : ValueLogic = ValueLogic.FALSE;

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.INPUT && port.get_value() == ValueLogic.TRUE){
                value = ValueLogic.TRUE;
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

    public function getDelay():Int {
        return delay;
    }

    public function new() {
    }
}
