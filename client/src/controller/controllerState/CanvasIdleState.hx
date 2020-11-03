package controller.controllerState;
import controller.Controller;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;
import model.similitudeEvents.EventTypesEnum;
import model.similitudeEvents.CanvasMouseDownEvent;
import model.similitudeEvents.SidebarDragAndDropEvent;
import model.component.CircuitElement;
import model.enumeration.Orientation;

/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasIdleState implements ControllerStateI
{

	public function new() 
	{
		
	}
	
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) : Void {
		if (event.getEventType() == EventTypesEnum.SIDEBAR_DRAG_N_DROP) {
			var dragNDropEvent = Std.downcast(event, SidebarDragAndDropEvent);
			trace('adding Component : ', dragNDropEvent.getComponent());
			var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
			var component = new Component(circuitDiagram, dragNDropEvent.draggedToX, dragNDropEvent.draggedToY, 70, 70, Orientation.EAST, controller.getComponentTypesSingleton().toComponentKind(dragNDropEvent.getComponent()) );
			controller.getModelManipulator().addComponent(component);
			controller.getModelManipulator().normalise( circuitDiagram );
			controller.getModelManipulator().checkPoint() ;
			controller.setState(this);
			return;
		}
		
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_DOWN) {
			var canvasMouseDownEvent = Std.downcast(event, CanvasMouseDownEvent);
			if (!canvasMouseDownEvent.didObjectsGetHit()) {
				var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
				controller.getModelManipulator().clearSelection(circuitDiagram, controller.getActiveTab().getSelectionModel());
				controller.setState(new DownOnEmptyState());
				return;
			}
			
			//// What if there are 2 endpoints in the objects hit array?
			var objectsHit  = canvasMouseDownEvent.getObjectsHit();
			var endpointsHit = new Array<Endpoint>();
			var componentsHit = new Array<Component>();
			var linksHit = new Array<Link>();
			var portsHit = new Array<Port>();
			
			for (object in objectsHit) {
				if (object.get_endpoint() != null) {
					endpointsHit.push(object.get_endpoint());
				}
				
				if (object.get_component() != null) {
					componentsHit.push(object.get_component());
				}
				
				if (object.get_link() != null) {
					linksHit.push(object.get_link());
				}
				
				if (object.get_port() != null) {
					portsHit.push(object.get_port());
				}
			}
			
			if (endpointsHit.length > 0) {
				// shift to link edit state
				controller.setState(new EditLinkState(endpointsHit[0]));
				return;
			} 
			
			// use case that shall be approached later
			if (portsHit.length > 0) {
				// do something
			}
			
			if (componentsHit.length > 0 || linksHit.length > 0) {
				trace("This will go for a selection");
				var clickedObjects = new Array<CircuitElement>();
				for (component in componentsHit) {
					clickedObjects.push(component);
				}

				for (link in linksHit) {
					clickedObjects.push(link);
				}
				
				controller.setState(new AddToSelectionState(clickedObjects, canvasMouseDownEvent.xPosition, canvasMouseDownEvent.yPosition));
				return;
			}
		} else {
			// do something
			//trace("Undefined event occured");
		}
	}
}