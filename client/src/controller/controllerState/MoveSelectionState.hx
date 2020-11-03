package controller.controllerState;
import controller.Controller;
import model.similitudeEvents.CanvasMouseMoveEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.EventTypesEnum;

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
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var activeTab = controller.getActiveTab();
			controller.getModelManipulator().moveSelection(
				activeTab,
				this.oldXPosition, this.oldYPosition,
				canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition);
			controller.setState(new MoveSelectionState(canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			controller.getModelManipulator().normalise(controller.getActiveTab().getCircuitDiagram() );
			controller.getModelManipulator().checkPoint() ;
			controller.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
}