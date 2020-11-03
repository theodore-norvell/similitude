import controller.Controller;
import view.attributeView.AttributeView;
import view.SidebarView;
import view.View;

class Main {
  // static entrypoint
  static function main() {
	  // create the main view
	var view:View = new View();
	
	// create the controllers
	var controller:Controller = new Controller();
	
	// attach the controller to the view
	view.setController(controller);
	
	// create the update pushers and bind them to the view.
	var sidebarView:SidebarView = new SidebarView();
	var attributeView: AttributeView = new AttributeView( view );
	
	// bind the controllers to the View interfaces
	controller.setAttributeView(attributeView);
	
	view.setActiveTab();
  }
}