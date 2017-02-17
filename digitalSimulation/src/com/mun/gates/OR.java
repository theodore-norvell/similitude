package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
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
public class OR extends ComponentKind {

	@Override
	public LinkedHashMap<IO, Port> algorithm(LinkedHashMap<IO, Port> portMap) {
	
		for(Port port : portMap.values()){//if any of the input value has the true value, then the output should be true
			if(port.getValue() == ValueLogic.TRUE){
				portMap.get(IO.OUTPUT).setValue(ValueLogic.TRUE);
				return portMap;
			}
		}
		
		////if all of the value of input is false, the output should be false
		portMap.get(IO.OUTPUT).setValue(ValueLogic.FALSE);
		return portMap;
	}

}
