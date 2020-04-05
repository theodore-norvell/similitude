import controller.controllers.CanvasController;
import controller.controllers.SidebarController;
import view.viewUpdaters.CanvasUpdate;
import view.viewUpdaters.SidebarUpdate;
import view.View;

class Main {
  // static entrypoint
  static function main() {
	  // create the main view
	var viewHandler:View = new View();
	
	// create the controllers
	var sidebarController:SidebarController = new SidebarController();
	var canvasController:CanvasController = new CanvasController();
	//var canvasController:CanvasController = new CanvasController();
	
	// attach the listeners/handlers to the view
	viewHandler.setSidebarListener(sidebarController);
	viewHandler.setCanvasListener(canvasController);
	
	// create the update pushers and bind them to the view.
	var sidebarUpdater:SidebarUpdate = new SidebarUpdate(viewHandler);
	var canvasUpdater:CanvasUpdate = new CanvasUpdate(viewHandler);
	
	// bind the controllers to the ViewUpdate interfaces
	sidebarController.setViewUpdater(sidebarUpdater);
	canvasController.setViewUpdater(canvasUpdater);
	
	viewHandler.setActiveTab();
  }

  // constructor
  //function new() {
  //}
}