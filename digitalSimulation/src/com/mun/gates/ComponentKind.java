package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;


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
	 * @param portMap using map to store all of the port including the input ports and output ports
	 * @return the port map which also contains all of the ports of this gate
	 */
	abstract public LinkedHashMap<IO, Port> algorithm(LinkedHashMap<IO, Port> portMap);
	
	
}
