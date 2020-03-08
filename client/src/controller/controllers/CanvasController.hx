package controller.controllers;
import controller.controllers.AbstractController;
import controller.listenerInterfaces.CanvasListener;

/**
 * ...
 * @author ...
 */
class CanvasController extends AbstractController implements CanvasListener
{

	public function new() 
	{
		
	}
	
	override public function update(a:String):Void 
	{
		this.viewUpdater.updateView("The element that was added to the canvas div is :: " + a );
	}
	
}