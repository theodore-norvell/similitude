package model.tabModel;
import model.drawingInterface.DrawingAdapterI;
	import model.selectionModel.CanvasPan;
//import js.html.CanvasRenderingContext2D;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.component.Link;
import model.selectionModel.SelectionModel;
//import js.Browser.document;  // No dependence from the Model package to Browser or HTML, please. TSN
//import js.html.Console; // No dependence from the Model package to Browser or HTML, please. TSN
//import haxe.Json;
//
/**
 * The tab model represents a tab in the entire UI.
 * It houses the circuit diagram,
 * tHe selection on the circuit diagram,
 * the canvas it will render to.
 * 
 * @author AdvaitTrivedi
 */
class TabModel 
// This should be Observable. TSN
{
	var selectionModel: SelectionModel;
	var circuitDiagram: CircuitDiagramI;
	public var canvasPan: CanvasPan = new CanvasPan();
	// create this field using  the JS document and then set it using the set functionality in this class.
	
	
	public function new(circuitDiagram: CircuitDiagramI) 
	{
		this.circuitDiagram = circuitDiagram;
		this.selectionModel = new SelectionModel(new Array<Link>(), new Array<Component>());
	}

	public function draw( drawingAdaptor : DrawingAdapterI ) : Void {
		this.circuitDiagram.draw( drawingAdaptor, this.selectionModel ) ;
	}
	
	public function getCircuitDiagram() : CircuitDiagramI {
		// Could we do without this method?
		return this.circuitDiagram;
	}
	
	public function getSelectionModel() : SelectionModel {
		// Could we do without this method?
		return this.selectionModel;
	}
	
	public function addLinksToSelection(links : Array<Link>) : Void {
		// This violates the abstraction. TSN
		this.selectionModel.getSelectedLinks().concat(links);
	}
	
	public function addComponentsToSelection(components: Array<Component>) : Void {
		// This violates the abstraction. TSN
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