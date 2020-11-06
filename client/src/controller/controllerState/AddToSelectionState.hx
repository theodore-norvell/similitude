package controller.controllerState;
import controller.Controller;
import model.component.CircuitElement;
import controller.similitudeEvents.CanvasMouseMoveEvent;
import controller.similitudeEvents.AbstractSimilitudeEvent;
import controller.similitudeEvents.EventTypesEnum;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddToSelectionState implements ControllerStateI
{
	var clickedObjects: Array<CircuitElement>;
	var xPosition: Float;
	var yPosition: Float;
	
	public function new(passedObject: Array<CircuitElement>, xOnClick: Float, yOnClick: Float)
	{
		this.clickedObjects = passedObject;
		this.xPosition = xOnClick;
		this.yPosition = yOnClick;
	}
	
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) {
		if (event.eventType == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var activeTab = controller.getActiveTab();
			controller.getCommander().moveSelection(activeTab, 
				this.xPosition, this.yPosition,
				canvasMouseMoveEvent.x, canvasMouseMoveEvent.y );
			controller.setState(new MoveSelectionState(canvasMouseMoveEvent.x, canvasMouseMoveEvent.y));
		} else if (event.eventType == EventTypesEnum.CANVAS_MOUSE_UP) {
			var activeTab = controller.getActiveTab();
			var selectionModel = activeTab.getSelectionModel() ;
			controller.getCommander().toggleSelectionArray(selectionModel, this.clickedObjects);
			controller.getCommander().checkPoint() ;
			// will change in the future
			controller.setState(new IdleState());
			var selectedComponents = activeTab.getSelectionModel().getComponentSet() ;
			if ( selectedComponents.size() > 0 ) {
				trace("triggering show attributes");
				controller.showAttributes();
			}
		} else {
			trace("Unknown transition");
		}
	}
	
}