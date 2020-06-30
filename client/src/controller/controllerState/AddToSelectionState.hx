package controller.controllerState;
import controller.listenerInterfaces.CanvasListener;
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
	
	public function operate(canvasListener: CanvasListener, event: AbstractSimilitudeEvent) {
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_MOVE) {
			var canvasMouseMoveEvent = Std.downcast(event, CanvasMouseMoveEvent);
			var activeTab = canvasListener.getActiveTab();
			canvasListener.getModelManipulator().moveSelection(activeTab, 
				this.xPosition, this.yPosition,
				canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition );
			canvasListener.setState(new MoveSelectionState(canvasMouseMoveEvent.xPosition, canvasMouseMoveEvent.yPosition));
		} else if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_UP) {
			var activeTab = canvasListener.getActiveTab();
			var selectionModel = activeTab.getSelectionModel() ;
			canvasListener.getModelManipulator().toggleSelectionArray(selectionModel, this.clickedObjects);
			canvasListener.getModelManipulator().checkPoint() ;
			// will change in the future
			canvasListener.setState(new CanvasIdleState());
			if (activeTab.getSelectionModel().onlyComponentsSelected()) {
				canvasListener.showAttributes(activeTab.getSelectionModel().getComponentSet());
			}
		} else {
			trace("Unknown transition");
		}
	}
	
}