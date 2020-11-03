package controller.controllerState;
import controller.Controller;
import model.component.Endpoint;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.EventTypesEnum;
import model.similitudeEvents.CanvasMouseMoveEvent;

/**
 * ...
 * @author AdvaitTrivedi
 */
class EditLinkState implements ControllerStateI
{
	var linkEndpoint: Endpoint;

	public function new(endpoint: Endpoint) 
	{
		this.linkEndpoint = endpoint;
	}
	
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) : Void {
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
			controller.getModelManipulator().editLink(circuitDiagram, this.linkEndpoint, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition);
			controller.setState(this);
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			controller.getModelManipulator().normalise( controller.getActiveTab().getCircuitDiagram() ) ;
			controller.getModelManipulator().checkPoint() ;
			controller.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
	
}