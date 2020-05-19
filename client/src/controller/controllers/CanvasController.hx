package controller.controllers;
import controller.commandManager.AddComponentCommand;
import controller.commandManager.AddLinkCommand;
import controller.commandManager.CommandManager;
import controller.commandManager.EditLinkCommand;
import controller.controllerState.CanvasIdleState;
import controller.controllerState.ControllerStateI;
import controller.controllers.AbstractController;
import controller.listenerInterfaces.CanvasListener;
import model.component.CircuitDiagram;
import model.component.Component;
import model.component.Link;
import model.enumeration.ComponentType;
import model.enumeration.Orientation;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.LinkAddEvent;
import model.similitudeEvents.LinkEditEvent;
import model.similitudeEvents.SidebarDragAndDropEvent;
import hx.strings.RandomStrings;
// import js.html.Console;

/**
 * ...
 * @author ...
 */
class CanvasController extends AbstractController implements CanvasListener
{
	var commandManager = new CommandManager();
	var componentTypesSingleton = new ComponentTypes(new CircuitDiagram());
	var state: ControllerStateI = new CanvasIdleState();
	
	public function new() 
	{
		
	}
	
	public function setState(newState: ControllerStateI) : Void {
		this.state = newState;
	}
	
	override public function update(a:String):Void {
		this.viewUpdater.updateView("The element that was added to the canvas div is :: " + a );
	}
	
	public function addComponentToCanvas(eventObject: SidebarDragAndDropEvent) : Void 
	{
		var commandUID = RandomStrings.randomAsciiAlphaNumeric(8);
		trace('adding Component : ', eventObject.getComponent());
		// create and execute a command here 
		// Type.createEnum(ComponentType, eventObject.component)
		var circuitDiagram = this.activeTab.getCircuitDiagram() ;
		var component = new Component(circuitDiagram, eventObject.draggedToX, eventObject.draggedToY, 70, 70, Orientation.EAST, componentTypesSingleton.toComponentKind(eventObject.getComponent()) );
		var addComponentCommand = new AddComponentCommand(circuitDiagram, component, commandUID);
		this.commandManager.executeCommand(addComponentCommand);
		this.viewUpdater.updateCanvas();
	}
	
	public function addLinkToCanvas(eventObject: LinkAddEvent) : Void {
		trace('adding Link : ', eventObject);
		var circuitDiagram = this.activeTab.getCircuitDiagram() ;
		var link = new Link(circuitDiagram, eventObject.addedAtX, eventObject.addedAtY, eventObject.addedAtX , eventObject.addedAtY - 10);
		var addLinkCommand = new AddLinkCommand(circuitDiagram, link);
		this.commandManager.executeCommand(addLinkCommand, true);
		this.viewUpdater.updateCanvas();
	}
	
	public function editLinkOnCanvas(eventObject: LinkEditEvent) : Void {
		trace('editing a link : ', eventObject);
		var circuitDiagram = this.activeTab.getCircuitDiagram() ;
		var editLinkCommand = new EditLinkCommand(circuitDiagram, eventObject.endpoint, eventObject.worldCoordinates);
		this.commandManager.executeCommand(editLinkCommand, true);
		this.viewUpdater.updateCanvas();
	}
	
	public function handleCanvasMouseInteractions(eventObject: CanvasMouseInteractionEvent) : Void {
		this.state.operate(this, eventObject);
	}
	
	public function getCommandManager() : CommandManager {
		return this.commandManager;
	}
	
	public function undoLastCanvasChange() {
		this.commandManager.undoCommand();
		this.viewUpdater.updateCanvas();
	}
	
	
	public function redoLastCanvasChange() {
		this.commandManager.redoCommand();
		this.viewUpdater.updateCanvas();
	}
	
	public function updateCanvas() {
		this.viewUpdater.updateCanvas();
	}
}
