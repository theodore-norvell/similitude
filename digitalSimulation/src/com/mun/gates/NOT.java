package com.mun.gates;

import java.util.LinkedHashMap;
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
	public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		if(valueLogicMap.containsValue(ValueLogic.TRUE)){//if input is true, the output should be false
			map.put(IO.OUTPUT, ValueLogic.FALSE);
		}else{//if the input is false, the output should be true
			map.put(IO.OUTPUT, ValueLogic.TRUE);
		}
		
		return map;
	}

}
