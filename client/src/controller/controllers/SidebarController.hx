package controller.controllers;
import controller.controllers.AbstractController;
import controller.listenerInterfaces.SidebarListener;

/**
 * ...
 * @author ...
 */
class SidebarController extends AbstractController implements SidebarListener
{
	public function new() 
	{
		
	}
	
	public override function update(a: String): Void {
		this.viewUpdater.updateView("Event occurred on : " + a);
	}
}