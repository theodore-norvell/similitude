package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
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
public class NOT extends ComponentKind {

	@Override
	public LinkedHashMap<IO, Port> algorithm(LinkedHashMap<IO, Port> portMap) {
				
		if(portMap.get(IO.INPUT).getValue() == ValueLogic.TRUE){//if input is true, the output should be false
			portMap.get(IO.OUTPUT).setValue(ValueLogic.FALSE);
		}else{//if the input is false, the output should be true
			portMap.get(IO.OUTPUT).setValue(ValueLogic.TRUE);
		}
		
		return portMap;
	}

}
