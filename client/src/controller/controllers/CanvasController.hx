package controller.controllers;
import controller.commandManager.AddComponentCommand;
import controller.commandManager.AddLinkCommand;
import controller.commandManager.CommandManager;
import controller.controllers.AbstractController;
import controller.listenerInterfaces.CanvasListener;
import model.component.CircuitDiagram;
import model.component.Component;
import model.component.Link;
import model.enumeration.ComponentType;
import model.enumeration.Orientation;
import model.similitudeEvents.SidebarDragAndDropEvent;
// import js.html.Console;

/**
 * ...
 * @author ...
 */
class CanvasController extends AbstractController implements CanvasListener
{
	var commandManager = new CommandManager();
	var componentTypesSingleton = new ComponentTypes(new CircuitDiagram());
	
	public function new() 
	{
		
	}
	
	override public function update(a:String):Void {
		this.viewUpdater.updateView("The element that was added to the canvas div is :: " + a );
	}
	
	public function addComponentToCanvas(eventObject: SidebarDragAndDropEvent) : Void 
	{
		trace('adding Component : ', eventObject.component);
		// create and execute a command here 
		// Type.createEnum(ComponentType, eventObject.component)
		var circuitDiagram = this.activeTab.getCircuitDiagram() ;
		var component = new Component(circuitDiagram, eventObject.draggedToX, eventObject.draggedToY, 70, 70, Orientation.EAST, componentTypesSingleton.toComponentKind(eventObject.component) );
		var addComponentCommand = new AddComponentCommand(circuitDiagram, component);
		this.commandManager.executeCommand(addComponentCommand);
		this.viewUpdater.updateCanvas();
	}
	
	public function addLinkToCanvas(eventObject: SidebarDragAndDropEvent) : Void {
		trace('adding Link : ', eventObject);
		var circuitDiagram = this.activeTab.getCircuitDiagram() ;
		var link = new Link(circuitDiagram, eventObject.draggedToX, eventObject.draggedToY, eventObject.draggedToX + 140, eventObject.draggedToY);
		var addLinkCommand = new AddLinkCommand(circuitDiagram, link);
		this.commandManager.executeCommand(addLinkCommand);
		this.viewUpdater.updateCanvas();
	}
	
	public function undoLastCanvasChange() {
		this.commandManager.undoCommand();
		this.viewUpdater.updateCanvas();
	}
	
	
	public function redoLastCanvasChange() {
		this.commandManager.redoCommand();
		this.viewUpdater.updateCanvas();
	}
}
