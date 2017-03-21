package com.mun.haxe.gates;
import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.component.Port;

/**
 * NOT gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *********************
 * *|input 1 | output |*<br>
 * *|   1    |    0   |*<br>
 * *|   0    |    1   |*<br>
 * *********************
 *  </pre>
 * @author wanhui
 *
 */
class NOT implements ComponentKind{
    var delay : Int = 0;//init is zero

    public function getDelay():Int {
    }

    public function setDelay(delay:Int):Void {
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
                if(value == ValueLogic.TRUE)
                    port.set_value(ValueLogic.FALSE);
                else if(value == ValueLogic.FALSE)
                    port.set_value(ValueLogic.TRUE);
                portArray.push(port);
            }
        }

        return portArray;
    }

    public function new() {
    }
}
