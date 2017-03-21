package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
/**
 * XOR gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    0   |*<br>
 * *|   0    |    1    |    1   |*<br>
 * *|   1    |    0    |    1   |*<br>
 * *|   0    |    0    |    0   |*<br>
 * ******************************* 
 *  </pre>
 * @author wanhui
 *
 */
public class XOR extends ComponentKind {

	@Override
	public LinkedHashMap<IO, Port> algorithm(LinkedHashMap<IO, Port> portMap) {
		int counter = 0;//this counter used to calculate how many ValueLogic.TRUE in the input
		
		for(Port port : portMap.values()){
			if(port.getValue() == ValueLogic.TRUE){
				counter ++;
			}
		}
		//for 2 or more inputs, if the number of  ValueLogic.TRUE is even, the output should be ValueLogic.FALSE
		//otherwise, the output should be ValueLogic.TRUE
		if(counter % 2 == 0){//even, so the output should be false
			portMap.get(IO.OUTPUT).setValue(ValueLogic.FALSE);
		}else{
			portMap.get(IO.OUTPUT).setValue(ValueLogic.TRUE);
		}
		
		return portMap;
	}

}
