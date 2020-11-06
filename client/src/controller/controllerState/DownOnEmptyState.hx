package controller.controllerState;
import controller.Controller;
import model.component.Link;
import controller.similitudeEvents.AbstractSimilitudeEvent;
import controller.controllerState.ControllerStateI;
import controller.similitudeEvents.CanvasMouseMoveEvent;
import controller.similitudeEvents.EventTypesEnum;

/**
 * Is hit when the canvas is clicked upon and the area is totally empty
 * @author AdvaitTrivedi
 */
class DownOnEmptyState implements ControllerStateI 
{
	var xPosition: Float;
	var yPosition: Float;

	public function new( xPosition: Float, yPosition: Float ) 
	{
		this.xPosition = xPosition ;
		this.yPosition = yPosition ;
	}
	
	
	/* INTERFACE controller.controllerState.ControllerStateI */
	
	public function operate(controller:Controller, event: AbstractSimilitudeEvent) : Void 
	{
		
		if (event.eventType == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
			// initate link adding sequence
			var link = new Link( circuitDiagram,
								 this.xPosition,
								 this.yPosition, 
								 canvasMouseMoveEvent.x,
								 canvasMouseMoveEvent.y );
			controller.getCommander().addLink(circuitDiagram, link);
			// shift to the link edit state
			controller.setState(new MoveEndpointState(link.get_endpoint(1)));
		} else if (event.eventType == EventTypesEnum.CANVAS_MOUSE_UP) {
			controller.clearAttributes() ;
			controller.getCommander().clearSelection( controller.getActiveTab().getSelectionModel());
			controller.getCommander().checkPoint() ;
			controller.setState(new IdleState()) ;
		} else {
			trace("Unknown transition");
		}
	}
	
}