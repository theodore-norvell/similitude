package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.Port;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
/**
 * output<br>
 * the output result is the same as input
 * @author wanhui
 *
 */
public class Output extends ComponentKind {
	private int sequence = 1;//the sequence of the output order
	
	//constructor
	public Output(int sequence) {
		super();
		this.sequence = sequence;
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
		// TODO Auto-generated method stub
		portMap.get(IO.INPUT).setValue(portMap.get(IO.OUTPUT).getValue());
		return portMap;
	}

}
