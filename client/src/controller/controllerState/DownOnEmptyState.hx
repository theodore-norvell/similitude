package controller.controllerState;
import controller.commandManager.AddLinkCommand;
import controller.commandManager.ClearSelectionCommand;
import model.component.Link;
import model.similitudeEvents.AbstractSimilitudeEvent;
import controller.listenerInterfaces.CanvasListener;
import controller.controllerState.ControllerStateI;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.CanvasMouseMoveEvent;
import model.similitudeEvents.CanvasMouseUpEvent;
import model.similitudeEvents.EventTypesEnum;
import hx.strings.RandomStrings;

/**
 * Is hit when the canvas is clicked upon and the area is totally empty
 * @author AdvaitTrivedi
 */
class DownOnEmptyState implements ControllerStateI 
{

	public function new() 
	{
		
	}
	
	
	/* INTERFACE controller.controllerState.ControllerStateI */
	
	public function operate(canvasListener:CanvasListener, event: AbstractSimilitudeEvent) : Void 
	{
		var circuitDiagram = canvasListener.getActiveTab().getCircuitDiagram() ;
		
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			// initate link adding sequence
			trace('adding Link : ', canvasMouseMoveEvent);
			var link = new Link(circuitDiagram, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition - 10);
			var addLinkCommand = new AddLinkCommand(circuitDiagram, link);
			canvasListener.getCommandManager().executeCommand(addLinkCommand, true);
			canvasListener.updateCanvas();
			// shift to the link edit state
			canvasListener.setState(new EditLinkState(link.get_endpoint(1)));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			// clear selection
			//var canvasMouseUpEvent = Std.downcast(event, CanvasMouseUpEvent);
			var clearSelectionCommand = new ClearSelectionCommand(circuitDiagram, canvasListener.getActiveTab().getSelectionModel());
			canvasListener.getCommandManager().executeCommand(clearSelectionCommand);
			canvasListener.updateCanvas();
	
			//var clearSelectionCommand = new ClearSelectionCommand(canvasListener.getActiveTab().getCircuitDiagram(), canvasListener.getActiveTab().getSelectionModel());
			//canvasListener.getCommandManager().executeCommand(clearSelectionCommand);
			canvasListener.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
	
}