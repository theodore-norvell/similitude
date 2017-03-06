package com.mun.haxe.gates;

import com.mun.haxe.enumeration.IOTYPE;
import com.mun.haxe.enumeration.ValueLogic;
import com.mun.haxe.component.Port;
/**
 * Flip-Flop<br>
 * Truth Table
 * <br>
 * <pre>
 * ****************************************
 * *|   CLK  |    D   |    Q   |    QN   |*<br>
 * *|    0   |    0   |    Q   |    QN   |*<br>
 * *|    0   |    1   |    Q   |    QN   |*<br>
 * *|    1   |    0   |    0   |    1    |*<br>
 * *|    1   |    1   |    1   |    0    |*<br>
 * ****************************************
 *  </pre>
 * @author wanhui
 *
 */
class FlipFlop implements ComponentKind{
    var delay : Int = 0;//init is zero

    public function getDelay():Int {
        return delay;
    }

    public function setDelay(delay:Int):Void {
        this.delay = delay;
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {
        var port : Port
        var value : ValueLogic = ValueLogic.TRUE;

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.CLK){
                if(port.get_value() != ValueLogic.RISING_EDGE){
                    //if clock is not at rising edge, then the value of flip-flop will not change
                    return portArray;
                }
            }
        }

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.D){
                value = port.get_value();
            }
        }

        for(port in portArray){
            if(port.get_portDescription() == IOTYPE.Q){
                portArray.remove(port);
                port.set_value(value);
                portArray.push(port);
            }

            if(port.get_portDescription() == IOTYPE.QN){
                portArray.remove(port);
                if(value == ValueLogic.TRUE){
                    port.set_value(value.FALSE);
                }else if(value == ValueLogic.FALSE){
                    port.set_value(value.TRUE);
                }
                portArray.push(port);
            }
        }
        return portArray;
    }

    public function new() {

    }
}
