package view;

import controller.listenerInterfaces.CanvasListener;
import controller.listenerInterfaces.SidebarListener;
import js.Browser.document;
import js.html.Console;
import controller.listenerInterfaces.ViewListener;

class View 
{
	var sidebarListener: SidebarListener;
	var canvasListener: CanvasListener;

	/**
	 * Populate the UI using this constructor.
	 */
	public function new() 
	{
		trace("DOM example");

		document.addEventListener("DOMContentLoaded", function(event) {
		trace("DOM ready");

		
		// for testing the scrollbar
		var sidebarPara = document.querySelector("p");
		sidebarPara.innerText = "
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.
";
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
		
		var canvasDisplayScreen = document.querySelector("#displayScreen");
		// needs this event by default for the drop target.
		canvasDisplayScreen.addEventListener('dragover', function (event) {
			event.preventDefault(); // called to avoid any other event from occuring when processing this one.
			event.dataTransfer.dropEffect = "move";
			// refer to MDN docs for more dropEffects
			
		});
		// needs this event by default for the drop target.
		canvasDisplayScreen.addEventListener('drop', function (event) {
			event.preventDefault();
			Console.log(event);
			Console.log(event.dataTransfer.items);
			var data = event.dataTransfer.getData("text/plain");
			Console.log(data);
			event.target.appendChild(document.querySelector("#" + data).cloneNode(true));
			this.canvasListener.update(data);
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
		
	}
	
}