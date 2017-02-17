package com.mun.gates;


import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;

/**
 * AND gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    1   |*<br>
 * *|   0    |    1    |    0   |*<br>
 * *|   1    |    0    |    0   |*<br>
 * *|   0    |    0    |    0   |*<br>
 * ******************************* 
 *  </pre>
 * @author wanhui
 *
 */
public class AND extends ComponentKind {
	
	@Override
	public LinkedHashMap<IO, Port> algorithm(LinkedHashMap<IO, Port> portMap) {
		for(Port port : portMap.values()){//if any of the port is equal to false, the result should be false
			if(port.getValue() == ValueLogic.FALSE && port.getPortDescription() == IO.INPUT){
				portMap.get(IO.OUTPUT).setValue(ValueLogic.FALSE);
				return portMap;
			}
		}
		portMap.get(IO.OUTPUT).setValue(ValueLogic.TRUE);
		return portMap;
	}
	
}
