package model.tabModel;
import model.drawingInterface.DrawingAdapterI;
import js.html.CanvasElement;
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
	var view: view.View;
	var selectionModel: SelectionModel;
	var circuitDiagram: CircuitDiagramI;
	// create this field using  the JS document and then set it using the set functionality in this class.
	var canvasElement : CanvasElement;
	
	public function new(circuitDiagram: CircuitDiagramI, view: view.View) 
	{
		this.view = view;
		this.circuitDiagram = circuitDiagram;
		this.selectionModel = new SelectionModel(new Array<Link>(), new Array<Component>());
		
		// The following commented code corresponds to the code in the view using the function view.spawnNewCanvas()
		// On a personal note I believe the Tab model should be capable of doing this on it's own.
		// the comments can be removed later on.
		
		//var canvasDisplayScreen = document.querySelector("#displayScreen");
		//
		//var innerCanvas = document.createCanvasElement();
		//innerCanvas.id = "canvasToDraw";
		//canvasDisplayScreen.appendChild(innerCanvas);
		//innerCanvas.style.width = "100%";
		//innerCanvas.style.height = "100%";
		//
		//// needs this event by default for the drop target.
		//canvasDisplayScreen.addEventListener('dragover', function (event) {
			//event.preventDefault(); // called to avoid any other event from occuring when processing this one.
			//event.dataTransfer.dropEffect = "move";
			//// refer to MDN docs for more dropEffects
			//
		//});
		//// needs this event by default for the drop target.
		//canvasDisplayScreen.addEventListener('drop', function (event) {
			//event.preventDefault();
			//var data = event.dataTransfer.getData("text/plain");
			//
			//// use this for co-ordinates of the mouse pointers on the current ancestor element
			//Console.log("co-ordinates ::", event.layerX, event.layerY);
			//// here make a function to draw on the canvas
			//// presumably move this entire block to the canvasUpdate
			//// use a command through the command manager here
			//var eventPassed = Json.parse(data);
			//// in element co-ordinates
			////eventPassed.posX = event.layerX;
			////eventPassed.posY = event.layerY;
			//eventPassed.posX = event.pageX;
			//eventPassed.posY = event.pageY;
			//this.view.updateCanvasListener(eventPassed);
			////this.canvasListener.update(data);
		//});
		//
		//this.canvasElement = innerCanvas;
		
		this.canvasElement = this.view.spawnNewCanvas();
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
	
	public function getCanvasContext() : CanvasElement {
		return this.canvasElement;
	}
	
	public function setCanvasContext(canvas : CanvasElement) : Void {
		this.canvasElement = canvas;
	}
	
}