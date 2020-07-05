import controller.controllers.CanvasController;
import view.viewUpdaters.AttributeUpdate;
import view.viewUpdaters.CanvasUpdate;
import view.viewUpdaters.SidebarUpdate;
import view.View;

class Main {
  // static entrypoint
  static function main() {
	  // create the main view
	var viewHandler:View = new View();
	
	// create the controllersß
	var canvasController:CanvasController = new CanvasController();
	//var canvasController:CanvasController = new CanvasController();
	
	// attach the listeners/handlers to the view
	viewHandler.setCanvasListener(canvasController);
	
	// create the update pushers and bind them to the view.
	var sidebarUpdater:SidebarUpdate = new SidebarUpdate(viewHandler);
	var canvasUpdater:CanvasUpdate = new CanvasUpdate(viewHandler);
	var attributeUpdater: AttributeUpdate = new AttributeUpdate(viewHandler);
	
	// bind the controllers to the ViewUpdate interfaces
	canvasController.setViewUpdater(canvasUpdater);
	canvasController.setAttributeUpdater(attributeUpdater);
	
	viewHandler.setActiveTab();
  }

  // constructor
  //function new() {
  //}
}