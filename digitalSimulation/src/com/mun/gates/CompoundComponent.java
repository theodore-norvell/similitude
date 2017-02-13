package com.mun.gates;

import java.util.LinkedHashMap;

import com.mun.component.CircuitDiagram;
import com.mun.emun.IO;
import com.mun.emun.ValueLogic;
/**
 * Compound component is used for user-designed gates<br>
 * Every compound component should consist by a lot of common gates which should be a circuit diagram<br>
 * The output of this compound component decide by the circuit diagram<br>
 * @author wanhui
 *
 */
public class CompoundComponent extends ComponentKind {
	/**
	 * Compound component is a circuit diagram
	 */
	private CircuitDiagram circuitDiagram;

	public CircuitDiagram getCircuitDiagram() {
		return circuitDiagram;
	}

	public void setCircuitDiagram(CircuitDiagram circuitDiagram) {
		this.circuitDiagram = circuitDiagram;
	}
	/**
	 * {@inheritDoc}<br><br><br>
	 * There is no actual algorithm for the compound component,
	 * the output value only defined by the circuit diagram. For the 
	 * current input should find the corresponding Input gate in the 
	 * inner circuit diagram.
	 */
	@Override
	public LinkedHashMap<IO, ValueLogic> algorithm(
			LinkedHashMap<IO, ValueLogic> valueLogicMap) {
		LinkedHashMap<IO, ValueLogic> map = new LinkedHashMap<IO, ValueLogic>();
		//find the input gate, and  calculate the value 
		
		
		return null;
	}

}
