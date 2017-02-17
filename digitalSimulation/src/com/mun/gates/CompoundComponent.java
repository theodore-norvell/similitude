package com.mun.gates;

import java.util.Collection;
import java.util.LinkedHashMap;

import com.mun.component.CircuitDiagram;
import com.mun.component.Port;
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
	 * {@inheritDoc}<br><br>
	 * There is no actual algorithm for the compound component,
	 * the output value only defined by the circuit diagram. For the 
	 * current input should find the corresponding Input gate in the 
	 * inner circuit diagram.<br>
	 */
	@Override
	public LinkedHashMap<IO, Port> algorithm(
			LinkedHashMap<IO, Port> portMap) {
		
		//find the input gate, and  calculate the value 
		for(int i = 0; i < circuitDiagram.getComponentArrayList().size(); i++){
			if( circuitDiagram.getComponentArrayList().get(i).getComponentKind().equals(new Input())){
				Input input = (Input) circuitDiagram.getComponentArrayList().get(i).getComponentKind();
				//the problem is how to figure out which port connect to which input
				
			}
		}
		
		return portMap;
	}

}
