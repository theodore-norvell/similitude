package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
/**
 * input<br>
 * the output is the same as input
 * @author wanhui
 *
 */
public class Input extends ComponentKind {
	private int sequence = 1;//the sequence of the input order in the diagram, the initial value is 1
	
	//constructor 
	public Input(int sequence) {
		super();
		this.sequence = sequence;
	}

	public Input() {
		super();
	}

	public int getSequence() {
		return sequence;
	}


	public void setSequence(int sequence) {
		this.sequence = sequence;
	}

	@Override
	public LinkedHashMap<IO, Port> algorithm(
			LinkedHashMap<IO, Port> portMap) {
		portMap.get(IO.OUTPUT).setValue(portMap.get(IO.INPUT).getValue());
		return portMap;
	}

}
