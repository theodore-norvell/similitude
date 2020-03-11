package model.tabModel;
import haxe.ds.List;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.component.Link;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class TabModel 
{

	var selectionModel: SelectionModel;
	var circuitDiagram: CircuitDiagramI;
	
	public function new(circuitDiagram: CircuitDiagramI) 
	{
		this.circuitDiagram = circuitDiagram;
		this.selectionModel = new SelectionModel(new Array<Link>(), new Array<Component>());
	}
	
	public function getCircuitDiagram() : CircuitDiagramI {
		return this.circuitDiagram;
	}
	
	public function getSelectionModel() : SelectionModel {
		return this.selectionModel;
	}
	
	public function addLinksToSelection(links : Array<Link>) : Void {
		this.selectionModel.getSelectedLinks().concat(links);
	}
	
	public function addComponentsToSelection(components: Array<Component>) : Void {
		this.selectionModel.getSelectedComponents().concat(components);
	}
	
	public function removeLinksFromSelection(links: Array<Link>) : Void {
		for (link in links) {
			this.selectionModel.removeLinkFromSelection(link);
		}
	}
	
	public function removeComponentsFromSelection(components: Array<Component>) : Void {
		for (component in components) {
			this.selectionModel.removeComponentFromSelection(component);
		}
	}
	
}