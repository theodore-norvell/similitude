package controller.controllerState;
import controller.commandManager.MoveSelectionCommand;
import controller.listenerInterfaces.CanvasListener;
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
	
	public function operate(canvasListener: CanvasListener, event: AbstractSimilitudeEvent) {
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var activeTab = canvasListener.getActiveTab();
			var moveSelectionCommand = new MoveSelectionCommand(activeTab.getCircuitDiagram(), activeTab.getSelectionModel(), this.oldXPosition, this.oldYPosition, canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition);
			canvasListener.getCommandManager().executeCommand(moveSelectionCommand, true);
			canvasListener.setState(new MoveSelectionState(canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			canvasListener.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
}