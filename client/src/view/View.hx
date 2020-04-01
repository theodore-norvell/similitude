package view;

import controller.listenerInterfaces.CanvasListener;
import controller.listenerInterfaces.SidebarListener;
import js.Browser.document;
import js.html.CanvasElement;
import js.html.Console;
import js.html.Window;
import haxe.Json;
import model.component.CircuitDiagram;
import view.DrawingAdapter;
import model.similitudeEvents.SidebarDragAndDropEvent;
import model.tabModel.TabModel;
import model.drawingInterface.Transform;
import view.viewModelRepresentatives.TabView;
import haxe.Unserializer;

class View 
{
	var sidebarListener: SidebarListener;
	var canvasListener: CanvasListener;
	var activeTab: TabView;
	var allTabs = new Array<TabView>();
	/**
	 * Populate the UI using this constructor.
	 */
	public function new() 
	{
		// letting this stay here for now
		// check out the matrix once to understand how it works.
		this.activeTab = new TabView(new CircuitDiagram(), this, Transform.identity());
		// this.setActiveTab();
		allTabs.push(activeTab);
		
		trace("DOM example");

		document.addEventListener("DOMContentLoaded", function(event) {
		trace("DOM ready");
		
		// for undo button
		document.querySelector("#undo").addEventListener('click', function (event) {
            // do something
			Console.log("undo was clicked");
			this.canvasListener.undoLastCanvasChange();
        });
		
		// for redo button
		document.querySelector("#redo").addEventListener('click', function (event) {
            // do something
			Console.log("redo was clicked");
			this.canvasListener.redoLastCanvasChange();
        });
		
		document.querySelector("#Up").addEventListener('click', function (event) {
            // do something
			Console.log("Up was clicked");
			// change the pan in the tabModel
			this.activeTab.tabModel.canvasPan.moveXNegative(10);
			// create a new canvas event
			var canvasPanEvent = new CanvasPanEvent();
			canvasPanEvent.yPan = -10;
			// update the canvas through the controller
			this.canvasListener.panCanvas(canvasPanEvent);
        });
		
		document.querySelector("#Down").addEventListener('click', function (event) {
            // do something
			Console.log("Down was clicked");
			// change the pan in the tabModel
			this.activeTab.tabModel.canvasPan.moveYPositive(10);
			// create a new canvas event
			var canvasPanEvent = new CanvasPanEvent();
			canvasPanEvent.yPan = 10;
			// update the canvas through the controller
			this.canvasListener.panCanvas(canvasPanEvent);
        });
		
		document.querySelector("#Left").addEventListener('click', function (event) {
            // do something
			Console.log("Left was clicked");
			// change the pan in the tabModel
			this.activeTab.tabModel.canvasPan.moveXNegative(10);
			// create a new canvas event
			var canvasPanEvent = new CanvasPanEvent();
			canvasPanEvent.xPan = -10;
			// update the canvas through the controller
			this.canvasListener.panCanvas(canvasPanEvent);
        });
		
		document.querySelector("#Right").addEventListener('click', function (event) {
            // do something
			Console.log("Right was clicked");
			// change the pan in the tabModel
			this.activeTab.tabModel.canvasPan.moveXPositive(10);
			// create a new canvas event
			var canvasPanEvent = new CanvasPanEvent();
			canvasPanEvent.xPan = 10;
			// update the canvas through the controller
			this.canvasListener.panCanvas(canvasPanEvent);
        });
		
		document.querySelector("#Centre").addEventListener('click', function (event) {
            // do something
			Console.log("Centre was clicked");
			// create a new canvas event
			var canvasPanEvent = new CanvasPanEvent();
			canvasPanEvent.xPan = this.activeTab.tabModel.canvasPan.centreX();
			canvasPanEvent.yPan = this.activeTab.tabModel.canvasPan.centreY();
			// update the canvas through the controller
			this.canvasListener.panCanvas(canvasPanEvent);
        });
		
		// for testing the flow of the click event
		document.querySelector("#clickMe").addEventListener('click', function (event) {
            // do something
			Console.log("clickable was clicked");
			this.sidebarListener.update("clickMe");
        });
		
		var draggableBox = document.querySelector("#dragMe");
		draggableBox.draggable = true; // need to set true for dragging.
		draggableBox.addEventListener('drag', function (event) {
            // do something
			Console.log("draggable is being dragged");
			//Console.log(event);
			
			
        });
		// also set the dragStart event to send data through the drag and drop
		draggableBox.addEventListener('dragstart', function(event) {
			// do not forget to set data before the transfer
			event.dataTransfer.setData("text/plain", event.target.id);
			Console.log(event.dataTransfer.items);
			event.dataTransfer.dropEffect = "move";
		});
    });
	
	}
	
	public function setSidebarListener(listener: SidebarListener){
		this.sidebarListener = listener;
	}
	
	public function setCanvasListener(listener: CanvasListener){
		this.canvasListener = listener;
	}
	
	public function updateThisBox(updateString: String){
		var updateThis= document.querySelector("#updateThis");
		updateThis.innerText = updateString;
	}
	
	public function updateSidebarOptions(){
		Console.log("updateSidebarOptions has been called");
	}
	
	/**
	 * A common function that accepts JSON / Dynamic objects to update the Canvas
	 * @param	eventObject
	 */
	public function updateCanvasListener(eventObject: SidebarDragAndDropEvent) {
		// add more cases to handle more stuff
		this.canvasListener.addComponentToCanvas(eventObject);
	}
	
	public function updateCanvas() : Void {
		Console.log('view.updateCanvas');
		var canvas = this.activeTab.canvasElement ;
		var context = canvas.getContext2d() ;
		context.clearRect(0, 0, canvas.width, canvas.height);
		var drawingAdapter = new DrawingAdapter(Transform.identity(), context);
		this.activeTab.tabModel.draw(drawingAdapter);
	}
	
	public function setActiveTab(){
		// do something for the active tab field
		//after that push it to the canvas controller
		this.canvasListener.setActiveTab(this.activeTab.tabModel);
	}
	
	public function spawnNewCanvas() : CanvasElement {
		var canvasDisplayScreen = document.querySelector("#displayScreen");
		
		var innerCanvas = document.createCanvasElement();
		// innerCanvas.id = "canvasToDraw"; // deal with this to get better and unique IDs, IF NEED BE
		canvasDisplayScreen.appendChild(innerCanvas);
		//innerCanvas.style.width = "100%";
		//innerCanvas.style.height = "100%";
		var cs = document.defaultView.getComputedStyle(canvasDisplayScreen);
		
		innerCanvas.style.width = "100%";
		innerCanvas.style.height = "100%";
		innerCanvas.style.border = "solid 1px black";
		innerCanvas.width = Std.parseInt(cs.getPropertyValue('width'));
		innerCanvas.height = Std.parseInt(cs.getPropertyValue('height'));
		
		// needs this event by default for the drop target.
		canvasDisplayScreen.addEventListener('dragover', function (event) {
			event.preventDefault(); // called to avoid any other event from occuring when processing this one.
			event.dataTransfer.dropEffect = "move";
			// refer to MDN docs for more dropEffects
			
		});
		// needs this event by default for the drop target.
		canvasDisplayScreen.addEventListener('drop', function (event) {
			event.preventDefault();
			var data = event.dataTransfer.getData("text/plain");
			
			// use this for co-ordinates of the mouse pointers on the current ancestor element
			//Console.log("co-ordinates ::", event.layerX, event.layerY);
			// here make a function to draw on the canvas
			// presumably move this entire block to the canvasUpdate
			// use a command through the command manager here
			//Console.log(event);
			//trace(event);
			//Console.log(Unserializer.run(data));
			//var eventPassed = Json.parse(data);
			// in element co-ordinates
			var eventPassed :SidebarDragAndDropEvent = Unserializer.run(data);
			trace(eventPassed);
			eventPassed.draggedToX = event.layerX-80;
			eventPassed.draggedToY = event.layerY-50;
			//eventPassed.draggedToX = event.pageX;
			//eventPassed.draggedToY = event.pageY;
			this.updateCanvasListener(eventPassed);
			//this.canvasListener.update(data);
		});
		
		return innerCanvas;
	}
	
}
