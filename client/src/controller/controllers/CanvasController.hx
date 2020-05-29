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
import model.similitudeEvents.AbstractSimilitudeEvent;
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
	
	public function getComponentTypesSingleton() : ComponentTypes {
		return this.componentTypesSingleton;
	}
	
	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) : Void {
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
}
