package controller.controllers;
import controller.viewUpdateInterfaces.ViewUpdate;
import controller.listenerInterfaces.ViewListener;
import model.component.CircuitDiagramI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractController implements ViewListener
{
	var viewUpdater: ViewUpdate;
	var activeCircuitDiagram: CircuitDiagramI;
	
	public function setViewUpdater(viewUpdater: ViewUpdate) {
		this.viewUpdater = viewUpdater;
	}
	
	public function setActiveCircuitDiagram(circuitDiagram: CircuitDiagramI) {
		this.activeCircuitDiagram = circuitDiagram;
	}
	
	public function getActiveCircuitDiagram() {
		return this.activeCircuitDiagram;
	}
	
	public function update(a: String): Void{}
}