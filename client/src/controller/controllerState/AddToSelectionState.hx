package controller.controllerState;
import controller.commandManager.AddToSelectionCommand;
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
	var clickedObjects: Array<CircuitElement>;
	
	public function new(passedObject: Array<CircuitElement>) 
	{
		this.clickedObjects = passedObject;
	}
	
	public function operate(canvasListener: CanvasListener, event: AbstractSimilitudeEvent) {
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			var activeTab = canvasListener.getActiveTab();
			for (object in this.clickedObjects) {
				canvasListener.getCommandManager().executeCommand(new AddToSelectionCommand(activeTab.getCircuitDiagram(), activeTab.getSelectionModel(), object));
			};
			canvasListener.setState(new CanvasIdleState());
		} else {
			trace("Unknown transition");
		}
	}
	
}