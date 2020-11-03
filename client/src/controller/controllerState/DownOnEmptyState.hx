package controller.controllerState;
import controller.Controller;
import model.component.Link;
import model.similitudeEvents.AbstractSimilitudeEvent;
import controller.controllerState.ControllerStateI;
import model.similitudeEvents.CanvasMouseMoveEvent;
import model.similitudeEvents.EventTypesEnum;

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
	
	public function operate(controller:Controller, event: AbstractSimilitudeEvent) : Void 
	{
		
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
			// initate link adding sequence
			var link = new Link(circuitDiagram, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition - 10);
			controller.getModelManipulator().addLink(circuitDiagram, link);
			// shift to the link edit state
			controller.setState(new EditLinkState(link.get_endpoint(1)));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			controller.clearAttributes();
			controller.getModelManipulator().checkPoint() ;
			controller.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
	
}