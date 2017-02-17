package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
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
public class FLIPFLOP extends ComponentKind {

	@Override
	public LinkedHashMap<IO, Port> algorithm(LinkedHashMap<IO, Port> portMap) {
		
		if(portMap.get(IO.CLK).getValue() != ValueLogic.RISING_EDGE){//if clock is not at rising edge, then the value of flip-flop will not change
			return portMap;
		}else{
			if(portMap.get(IO.D).getValue() == ValueLogic.FALSE){
				portMap.get(IO.Q).setValue(ValueLogic.FALSE);
				portMap.get(IO.QN).setValue(ValueLogic.TRUE);
			}else{
				portMap.get(IO.Q).setValue(ValueLogic.TRUE);
				portMap.get(IO.QN).setValue(ValueLogic.FALSE);
			}
		}
		return portMap;
	}

}
