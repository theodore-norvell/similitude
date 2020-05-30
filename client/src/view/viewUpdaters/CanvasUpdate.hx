package view.viewUpdaters;
import view.viewUpdaters.AbstractUpdate;
import js.Browser.document;
import js.html.Console;
import haxe.Json;

/**
 * The class responsible for handling canvas updates.
 * @author ...
 */
class CanvasUpdate extends AbstractUpdate
{

	public function new(view: View){
		super.setViewToUpdate(view);
	}
	
	public override function updateView(string: String): Void{
		//this.viewToUpdate.updateThisBox(string);
		// for now this updates the same box as the sidebar.
		// for testing.
		// we can and should change this later.
	}
	
	public override function updateCanvas() : Void {
		this.viewToUpdate.updateCanvas();
	}
	
}