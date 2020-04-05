package view;

import type.Coordinate;
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
			this.activeTab.panCanvasUp();
        });
		
		document.querySelector("#Down").addEventListener('click', function (event) {
            // do something
			Console.log("Down was clicked");
			this.activeTab.panCanvasDown();
        });
		
		document.querySelector("#Left").addEventListener('click', function (event) {
            // do something
			Console.log("Left was clicked");
			this.activeTab.panCanvasLeft();
        });
		
		document.querySelector("#Right").addEventListener('click', function (event) {
            // do something
			Console.log("Right was clicked");
			this.activeTab.panCanvasRight();
        });
		
		document.querySelector("#Centre").addEventListener('click', function (event) {
            // do something
			Console.log("Centre was clicked");
			this.activeTab.panCanvasCentre();
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

	/**
	 * A common function that accepts JSON / Dynamic objects to update the Canvas
	 * @param	eventObject
	 */
	public function updateCanvasListener(eventObject: SidebarDragAndDropEvent) {
		// add more cases to handle more stuff
		this.canvasListener.addComponentToCanvas(eventObject);
	}
	
	/**
	 * This serves a function for the controller to hit as they cannot reach out top the tabView directly
	 */
	public function updateCanvas() : Void {
		Console.log('view.updateCanvas');
		this.activeTab.update();
	}
	
	public function setActiveTab(){
		// do something for the active tab field
		//after that push it to the canvas controller
		this.canvasListener.setActiveTab(this.activeTab.tabModel);
	}
	
	public function spawnNewCanvas() : CanvasElement {
		// TODO.  It seems to me (TSN) that this routine should be moved to the TabView class.
		var canvasDisplayScreen = document.querySelector("#displayScreen");
		
		var innerCanvas = document.createCanvasElement();
		// innerCanvas.id = "canvasToDraw"; // deal with this to get better and unique IDs, IF NEED BE
		canvasDisplayScreen.appendChild(innerCanvas);
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
			var eventPassed :SidebarDragAndDropEvent = Unserializer.run(data);
			var viewCoord = new Coordinate( event.layerX-80, event.layerY-50) ;
			// TODO: Where does this magic numbers of 80 and 50 come from?
			var worldCoords = activeTab.viewToWorld( viewCoord ) ;
			eventPassed.draggedToX = worldCoords.get_xPosition() ;
			eventPassed.draggedToY = worldCoords.get_yPosition() ;
			trace(eventPassed);
			//eventPassed.draggedToX = event.pageX;
			//eventPassed.draggedToY = event.pageY;
			this.updateCanvasListener(eventPassed);
		});
		
		return innerCanvas;
	}
	
}
