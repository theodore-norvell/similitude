package controller.controllerState;
import controller.Controller;
import controller.similitudeEvents.CanvasMouseMoveEvent;
import controller.similitudeEvents.AbstractSimilitudeEvent;
import controller.similitudeEvents.EventTypesEnum;

/**
 * ...
 * @author AdvaitTrivedi
 */
class MoveSelectionState implements ControllerStateI
{
	var oldXPosition: Float;
	var oldYPosition: Float;

	public function new(oldX: Float, oldY: Float) 
	{
		this.oldXPosition = oldX;
		this.oldYPosition = oldY;
	}
	
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) {
		if (event.eventType == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var activeTab = controller.getActiveTab();
			controller.getCommander().moveSelection(
				activeTab,
				this.oldXPosition, this.oldYPosition,
				canvasMouseMoveEvent.x, canvasMouseMoveEvent.y);
			controller.setState(new MoveSelectionState(canvasMouseMoveEvent.x, canvasMouseMoveEvent.y));
		} else if (event.eventType == EventTypesEnum.CANVAS_MOUSE_UP) {
			controller.getCommander().normalise(controller.getActiveTab().getCircuitDiagram() );
			controller.getCommander().checkPoint() ;
			controller.setState(new IdleState());
		} else {
			trace("Unknown transition");
		}
	}
}