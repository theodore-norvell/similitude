package com.mun.gates;

import java.util.LinkedHashMap;
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
	public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		
		if(map.get(IO.CLK) != ValueLogic.RISING_EDGE){//if clock is not at rising edge, then the value of flip-flop will not change
			map = valueLogicMap;
		}else{
			if(map.get(IO.D) == ValueLogic.FALSE){
				map.put(IO.Q, ValueLogic.FALSE);
				map.put(IO.QN, ValueLogic.TRUE);
			}else{
				map.put(IO.Q, ValueLogic.TRUE);
				map.put(IO.QN, ValueLogic.FALSE);
			}
		}
		return map;
	}

}
