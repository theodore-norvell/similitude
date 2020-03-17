package view.viewUpdaters;
import js.html.CanvasElement;
import js.html.DivElement;
import model.component.Component;
import model.drawingInterface.DrawingAdapterI;
import view.viewUpdaters.AbstractUpdate;
import model.enumeration.ORIENTATION;
/**
 * Class in charge of handling the updates sent by the controller to the UI.
 * It willl ensure pushing changes to the UI, through the View class it can access.
 */
class SidebarUpdate extends AbstractUpdate
{
	
	public function new(view: View){
		super.setViewToUpdate(view);
	}
	
	/**
	 * Function to create a sidebar item, a div that holds the sidebar item.
	 * One can pass an optional component in here to have it pushed as a sidebar Item.
	 * The optional parameter component is given with the view that the function might be reused further.
	 * @return
	 */
	public function createSidebarItemElement(drawingAdapter: DrawingAdapterI, drawComponentString: String, ?component: Component) : DivElement {
		// the idea is to have constant width and height for each element
		var height = 50;
		var width = 50;
		
		var sidebarItem = new DivElement();
		sidebarItem.style.height = height + "px";
		sidebarItem.style.width = width + "px";
		var sidebarItemCanvas = new CanvasElement();
		drawingAdapter.setContext(sidebarItemCanvas.getContext2d());
		
		// add more defaults when needed
		if (drawComponentString == "AND") {
			// I am making the assumption that the adapter will draw in the canvas itself.
			drawingAdapter.drawAndShape(0,0, width, height, ORIENTATION.EAST);
		}
		else if (drawComponentString == "NAND") {
			
		}
		else if (drawComponentString == "OR") {
			
		}
		else if (drawComponentString == "NOR") {
			
		}
		else if (drawComponentString == "XOR") {
			
		}
		else if (drawComponentString == "NOT") {
			
		}
		else if (drawComponentString == "compoundComponent") {
			
		}
		
		return sidebarItem;
	}
	
	/**
	 * responsible for poopulating the sidebar on first startup
	 */ 
	public function populateSidebar()  : Void {
	}
	
	public override function updateView(string: String){
		this.viewToUpdate.updateThisBox(string);
	}
	
}