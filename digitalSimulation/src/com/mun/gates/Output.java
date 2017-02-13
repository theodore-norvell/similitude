package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
/**
 * output<br>
 * the output result is the same as input
 * @author wanhui
 *
 */
public class Output extends ComponentKind {

	@Override
	public LinkedHashMap<IO, ValueLogic> algorithm(
			LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		// TODO Auto-generated method stub
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		map.put(IO.OUTPUT, valueLogicMap.get(IO.INPUT));
		return map;
	}

}
