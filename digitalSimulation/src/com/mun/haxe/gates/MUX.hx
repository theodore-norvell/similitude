package com.mun.haxe.gates;

import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.component.Port;

/**
 * 2-1 MUX<br>
 * For MUX, the format in the map should be like this:<br>
 * (IO.S, ValueLogic),(IO.INPUT, valueLogic),(IO.INPUT, valueLogic)<br>
 * IO.S must put in the first place<br>
 * Truth Table
 * <br>
 * <pre>
 * ***************************************
 * *|   S   |input 1 | input 2 | output |*<br>
 * *|   0   |   1    |    1    |    1   |*<br>
 * *|   0   |   1    |    0    |    1   |*<br>
 * *|   0   |   0    |    1    |    0   |*<br>
 * *|   0   |   0    |    0    |    0   |*<br>
 * *|   1   |   1    |    1    |    1   |*<br>
 * *|   1   |   1    |    0    |    0   |*<br>
 * *|   1   |   0    |    1    |    1   |*<br>
 * *|   1   |   0    |    0    |    0   |*<br>
 * ***************************************
 *  </pre>
 * @author wanhui
 *
 */
class MUX implements ComponentKind{
    var delay : Int = 0;// init is zero

    public function getDelay():Int {
    }

    public function setDelay(delay:Int):Void {
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port : Port;
        var value : ValueLogic = ValueLogic.TRUE;
        var selectValue : ValueLogic;

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.S){
                selectValue = port.get_value();
                break;
            }
        }

        //if s == 1 the output should as the same as the input 2
        if(selectValue == ValueLogic.TRUE){
            for(port in portArray){
                if(port.get_sequence() == 2){
                    value = port.get_value();
                    break;
                }
            }
        }else if(selectValue == ValueLogic.FALSE){//if S == 0, the output should as the same as input 1
            for(port in portArray){
                if(port.get_sequence() == 1){
                    value = port.get_value();
                    break;
                }
            }
        }

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.OUTPUT){
                portArray.remove(port);
                port.set_value(value);
                portArray.push(port);
                break;
            }
        }
        return portArray;
    }

    public function new() {
    }
}
