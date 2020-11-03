package view ;
import haxe.Json;
import haxe.Serializer;
import js.html.DivElement;
import model.component.Component;
import view.drawingImpl.DrawingAdapter;
import model.similitudeEvents.SidebarDragAndDropEvent;
import model.enumeration.Orientation;
import model.enumeration.ComponentType;
import model.drawingInterface.Transform;
import js.Browser.document;
import js.html.Console;
import model.similitudeEvents.*;

/**
 * Class in charge of handling the updates sent by the controller to the UI.
 * It willl ensure pushing changes to the UI, through the View class it can access.
 */
class SidebarView 
{
	
	public function new(){
		this.populateSidebar();
	}
	
	/**
	 * Function to create a sidebar item, a div that holds the sidebar item.
	 * One can pass an optional component in here to have it pushed as a sidebar Item.
	 * The optional parameter component is given with the view that the function might be reused further.
	 * @return
	 */
	private function createSidebarItemElement(drawComponentString: Dynamic, ?component: Component) : DivElement {
		// the idea is to have constant width and height for each element
		var height = 50;
		var width = 50;
		
		var sidebarItem = document.createDivElement();
		sidebarItem.id = "sidebarItem_" + Std.string(drawComponentString);
		sidebarItem.style.height = height + "px";
		sidebarItem.style.width = "100%";
		sidebarItem.style.border = "solid 1px black";
		
		// how to make things draggable.
		// do not forget to check the receiving element code
		sidebarItem.draggable = true; // need to set true for dragging.
		sidebarItem.addEventListener('drag', function (event) {
            // do something
        });
		
		// also set the dragStart event to send data through the drag and drop
		sidebarItem.addEventListener('dragstart', function(event) {
			// do not forget to set data before the transfer
			var dndEvent = new SidebarDragAndDropEvent(drawComponentString);
			var draggedItemEvent = dndEvent;
			var stringEvent = Serializer.run(draggedItemEvent);
			trace(stringEvent);
			event.dataTransfer.setData("text/plain", stringEvent);
			event.dataTransfer.dropEffect = "move";
		});
		
		var sidebarItemCanvas = document.createCanvasElement();
		sidebarItem.appendChild(sidebarItemCanvas);
		sidebarItemCanvas.style.width = "100%";
		sidebarItemCanvas.style.height = "100%";
		
		var drawingAdapter = new DrawingAdapter(Transform.identity(), sidebarItemCanvas.getContext2d());
		
		// add more defaults when needed
		// use the optional component parameter for this.
		switch (drawComponentString) {
			case ComponentType.AND : drawingAdapter.drawAndShape(80,75, 70, 70, Orientation.EAST);
			case ComponentType.OR : drawingAdapter.drawOrShape(80,75, 70, 70, Orientation.EAST);
			case ComponentType.XOR : drawingAdapter.drawXorShape(80,75, 70, 70, Orientation.EAST);
			case ComponentType.NOT : drawingAdapter.drawNotShape(80,75, 70, 70, Orientation.EAST);
			case ComponentType.COMPOUND_COMPONENT : Console.log("CC");
		}
		
		return sidebarItem;
	}
	
	/**
	 * responsible for poopulating the sidebar on first startup
	 */ 
	public function populateSidebar()  : Void {
		// this handles cases for the default logic gates in general
		var defaultSidebarItems : Array<Dynamic> = [
			ComponentType.AND, 
			ComponentType.OR, 
			ComponentType.XOR,
			ComponentType.NOT, 
		];
		
		var sidebarTable = document.querySelector("#sidebarTable");
		var tableBody = sidebarTable.childNodes[1];
		
		for (defaultItem in defaultSidebarItems) {
			var tr = document.createTableRowElement();
			var td = tr.insertCell(0);
			td.appendChild(this.createSidebarItemElement(defaultItem));
			tableBody.appendChild(tr);
		}
	}
	
}