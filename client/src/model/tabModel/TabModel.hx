package model.tabModel;
import model.drawingInterface.DrawingAdapterI;
import model.observe.*;
import view.viewModelRepresentatives.TabView;
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
class TabModel implements Observer extends Observable
// This should be Observable. TSN
{
	var selectionModel: SelectionModel;
	var circuitDiagram: CircuitDiagramI;
	// create this field using  the JS document and then set it using the set functionality in this class.
	
	
	public function new(circuitDiagram: CircuitDiagramI, tabView: TabView) 
	{
		this.circuitDiagram = circuitDiagram;
		this.selectionModel = new SelectionModel();
		this.circuitDiagram.addObserver(this);
		this.selectionModel.addObserver(this);
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
	
	public function update(target: ObservableI, ?data: Any) : Void {
		this.notifyObservers(target, data);
	}
}