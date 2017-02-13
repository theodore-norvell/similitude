package com.mun.gates;

import java.util.LinkedHashMap;
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
	public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		int counter = 0;//this counter used to calculate how many ValueLogic.TRUE in the input
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		
		for(ValueLogic valueLogic : valueLogicMap.values()){
			if(valueLogic == ValueLogic.TRUE){
				counter ++;
			}
		}
		//for 2 or more inputs, if the number of  ValueLogic.TRUE is even, the output should be ValueLogic.FALSE
		//otherwise, the output should be ValueLogic.TRUE
		if(counter % 2 == 0){//even, so the output should be false
			map.put(IO.OUTPUT, ValueLogic.FALSE);
		}else{
			map.put(IO.OUTPUT, ValueLogic.TRUE);
		}
		
		return map;
	}

}
