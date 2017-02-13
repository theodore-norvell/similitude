package com.mun.gates;

import java.util.LinkedHashMap;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
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
public class NOR extends ComponentKind {

	@Override
	public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		if(valueLogicMap.containsValue(ValueLogic.TRUE)){//if any of the input value has the true value, then the output should be false
			map.put(IO.OUTPUT, ValueLogic.FALSE);
		}else{//if all of the value of input is false, the output should be true
			map.put(IO.OUTPUT, ValueLogic.TRUE);
		}
		
		return map;
	}

}
