package com.mun.gates;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.ListIterator;
import java.util.Map;

import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
/**
 * 2-1 MUX<br>
 * For MUX, the format in the map should be like this:<br>
 * (IO.S, ValueLogic),(IO.INPUT, valueLogic),(IO.INPUT, valueLogic)<br>
 * IO.S must put in the first place<br>
 * Truth Table
 * <br>
 * <pre>
 * ***************************************
 * *|   S   |input 1 | input 2 | output |*<br>
 * *|   0   |   1    |    1    |    1   |*<br>
 * *|   0   |   1    |    0    |    1   |*<br>
 * *|   0   |   0    |    1    |    0   |*<br>
 * *|   0   |   0    |    0    |    0   |*<br>
 * *|   1   |   1    |    1    |    1   |*<br>
 * *|   1   |   1    |    0    |    0   |*<br>
 * *|   1   |   0    |    1    |    1   |*<br>
 * *|   1   |   0    |    0    |    0   |*<br>
 * ***************************************
 *  </pre>
 * @author wanhui
 *
 */
public class MUX extends ComponentKind {

	@Override
	public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		if(valueLogicMap.get(IO.S) == ValueLogic.FALSE){//if S == 0, the output should as the same as input 1
			valueLogicMap.remove(IO.S);
			for(ValueLogic value : valueLogicMap.values()){
				map.put(IO.OUTPUT, value);
				break;
			}
		}else{//if s == 1 the output should as the same as the input 2
			ListIterator<Map.Entry<IO, ValueLogic>> i = new ArrayList<Map.Entry<IO, ValueLogic>>(valueLogicMap.entrySet()).listIterator(valueLogicMap.size());
			while(i.hasPrevious()){
				Map.Entry<IO, ValueLogic> entry = i.previous();
				map.put(IO.OUTPUT, entry.getValue());
				break;
			}
		}
		return map;
	}

}
