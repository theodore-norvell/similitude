package controller.controllerState;
import controller.commandManager.AddLinkCommand;
import model.component.Link;
import model.similitudeEvents.AbstractSimilitudeEvent;
import controller.listenerInterfaces.CanvasListener;
import controller.controllerState.ControllerStateI;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.CanvasMouseMoveEvent;
import model.similitudeEvents.EventTypesEnum;

/**
 * ...
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
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			// initate link adding sequence
			trace('adding Link : ', canvasMouseMoveEvent);
			var circuitDiagram = canvasListener.getActiveTab().getCircuitDiagram() ;
			var link = new Link(circuitDiagram, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition - 10);
			var addLinkCommand = new AddLinkCommand(circuitDiagram, link);
			canvasListener.getCommandManager().executeCommand(addLinkCommand, true);
			canvasListener.updateCanvas();
			// shift to the link edit state
			canvasListener.setState(new EditLinkState(link.get_endpoint(1)));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			canvasListener.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
	
}