package com.mun.gates;

import java.util.LinkedHashMap;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
/**
 * NAND gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|    1   |    1    |    0   |*<br>
 * *|    0   |    1    |    1   |*<br>
 * *|    1   |    0    |    1   |*<br>
 * *|    0   |    0    |    1   |*<br>
 * ******************************* 
 *  </pre>
 * @author wanhui
 *
 */
public class NAND extends ComponentKind {

	@Override
	public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		if(valueLogicMap.containsValue(ValueLogic.FALSE)){//if any of the input value has the false value, then the output should be true
			map.put(IO.OUTPUT, ValueLogic.TRUE);
		}else{//if all of the value of input is true, the output should be false
			map.put(IO.OUTPUT, ValueLogic.FALSE);
		}
		
		return map;
	}

}
