package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import hx.strings.RandomStrings;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractCommand
{
	var commandUID: String = RandomStrings.randomAsciiAlphaNumeric(12);
	var circuitDiagram: CircuitDiagramI;
	
	private function new(circuitDiagram: CircuitDiagramI) {
		this.circuitDiagram = circuitDiagram;
	}
	
	public function getCircuitDiagram() {
		return this.circuitDiagram;
	}
	
	public function getCommandUID() : String {
		return this.commandUID;
	}
	
	public function setCommandUID(uid: String) : Void {
		this.commandUID = uid;
	}

}