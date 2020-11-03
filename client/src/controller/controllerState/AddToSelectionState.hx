package controller.controllerState;
import controller.Controller;
import model.component.CircuitElement;
import model.similitudeEvents.CanvasMouseMoveEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.EventTypesEnum;

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
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var activeTab = controller.getActiveTab();
			controller.getModelManipulator().moveSelection(activeTab, 
				this.xPosition, this.yPosition,
				canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition );
			controller.setState(new MoveSelectionState(canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			var activeTab = controller.getActiveTab();
			var selectionModel = activeTab.getSelectionModel() ;
			controller.getModelManipulator().toggleSelectionArray(selectionModel, this.clickedObjects);
			controller.getModelManipulator().checkPoint() ;
			// will change in the future
			controller.setState(new CanvasIdleState());
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