package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.emun.IO;
import com.mun.emun.ValueLogic;


/**
 * abstract class for gates
 * the initial gate we have are
 * AND gate, OR gate, NAND gate, XOR gate, NOR gate, 2-1 MUX, FLIP-FLOP, NOT GATE
 * also input and output we regard them as gates
 * @author wanhui
 *
 */
public abstract class ComponentKind {
	private int delay = 0;//the gate delay, the initial value is 0
	
	public int getDelay() {
		return delay;
	}

	public void setDelay(int delay) {
		this.delay = delay;
	}

	/**
	 * Every gate should have a algorithm to define the output value.
	 * this method is to calculate the gate value.
	 * The reason why use Map is because for every input and output we
	 * should identify what the value belongs to. 
	 * @param valueLogicMap using map to store all of the input values 
	 * @return all of the output values
	 */
	abstract public LinkedHashMap<IO, ValueLogic> algorithm(LinkedHashMap<IO, ValueLogic> valueLogicMap);
	
	
}
