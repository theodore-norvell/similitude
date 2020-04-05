package controller.commandManager;
import model.component.CircuitDiagramI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractCommand implements CommandI
{
	var circuitDiagram: CircuitDiagramI;
	
	public function setCircuitDiagram(circuitDiagram: CircuitDiagramI) {
		this.circuitDiagram = circuitDiagram;
	}
	
	public function getCircuitDiagram() {
		return this.circuitDiagram;
	}
	
	public function execute() : Void {};
	public function redo() : Void {};
	public function undo() : Void {};
}