package view;

import controller.listenerInterfaces.CanvasListener;
import controller.listenerInterfaces.SidebarListener;
import js.Browser.document;
import js.html.Console;
import model.component.CircuitDiagram;
import model.drawingInterface.DrawingAdapter;
import model.tabModel.TabModel;
import model.drawingInterface.Transform;

class View 
{
	var sidebarListener: SidebarListener;
	var canvasListener: CanvasListener;
	var activeTab: TabModel;
	var allTabs = new Array<TabModel>();
	/**
	 * Populate the UI using this constructor.
	 */
	public function new() 
	{
		// letting this stay here for now
		this.activeTab = new TabModel(new CircuitDiagram(), this);
		// this.setActiveTab();
		allTabs.push(activeTab);
		
		trace("DOM example");

		document.addEventListener("DOMContentLoaded", function(event) {
		trace("DOM ready");

		
		// for testing the scrollbar
		//var sidebarPara = document.querySelector("p");
		//sidebarPara.innerText = "
//Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.
//";
		//var gate = document.createElement();
		//sidebar.style.border = "solid";
		//sidebar.style.borderRadius = "15px";
		//sidebar.style.border = "#224747";
		
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
	public function updateCanvasListener(eventObject: Dynamic) {
		// add more cases to handle more stuff
		if (eventObject.eventType == "sidebarDrag") {
			this.canvasListener.addComponentToCanvas(eventObject);
		}
	}
	
	public function updateCanvas() : Void {
		Console.log('view.updateCanvas');
		var drawingAdapter = new DrawingAdapter(Transform.identity(), this.activeTab.getCanvasContext().getContext2d());
		this.activeTab.getCircuitDiagram().draw(drawingAdapter);
	}
	
	public function setActiveTab(){
		// do something for the active tab field
		//after that push it to the canvas controller
		this.canvasListener.setActiveTab(this.activeTab);
	}
	
}