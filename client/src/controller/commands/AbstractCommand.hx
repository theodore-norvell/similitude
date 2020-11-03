package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import hx.strings.RandomStrings;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractCommand implements CommandI
{
	var commandUID: String = RandomStrings.randomAsciiAlphaNumeric(12);
	var circuitDiagram: CircuitDiagramI;
	
	public function setCircuitDiagram(circuitDiagram: CircuitDiagramI) {
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
	
	public function execute() : Void {};
	public function redo() : Void {};
	public function undo() : Void {};
}