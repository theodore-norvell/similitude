package controller.controllerState;
import controller.listenerInterfaces.CanvasListener;
import model.component.CircuitElement;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.EventTypesEnum;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddToSelectionState implements ControllerStateI
{
	var clickedObject: CircuitElement;
	
	public function new(passedObject: CircuitElement) 
	{
		this.clickedObject = passedObject;
	}
	
	public function operate(canvasListener: CanvasListener, event: AbstractSimilitudeEvent) {
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			canvasListener.getActiveTab().getSelectionModel().addCircuitElement(clickedObject);
		} else {
			trace("Unknown transition");
		}
	}
	
}