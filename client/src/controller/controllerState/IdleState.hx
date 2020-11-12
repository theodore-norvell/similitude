package controller.controllerState;
import controller.Controller;
import controller.similitudeEvents.AbstractSimilitudeEvent;
import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;
import controller.similitudeEvents.EventTypesEnum;
import controller.similitudeEvents.CanvasMouseDownEvent;
import controller.similitudeEvents.SidebarDragAndDropEvent;
import model.component.CircuitElement;
import model.enumeration.Orientation;

/**
 * ...
 * @author AdvaitTrivedi
 */
class IdleState implements ControllerStateI
{

	public function new() 
	{
		
	}
	
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) : Void {
		// TODO.  Make this state consistant with the documented state machine.
		if (event.eventType == EventTypesEnum.SIDEBAR_DRAG_N_DROP) {
			var dragNDropEvent = Std.downcast(event, SidebarDragAndDropEvent);
			trace('adding Component : ', dragNDropEvent.getComponent());
			var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
			var component = new Component(circuitDiagram, dragNDropEvent.draggedToX, dragNDropEvent.draggedToY, 70, 70, Orientation.EAST, controller.getComponentTypesSingleton().toComponentKind(dragNDropEvent.getComponent()) );
			controller.getCommander().addComponent(component);
			controller.getCommander().normalise( circuitDiagram );
			controller.getCommander().checkPoint() ;
			controller.setState(this);
			return;
		}
		
		if (event.eventType == EventTypesEnum.CANVAS_MOUSE_DOWN) {
			var canvasMouseDownEvent = Std.downcast(event, CanvasMouseDownEvent);
			if (!canvasMouseDownEvent.didObjectsGetHit()) {
				var circuitDiagram = controller.getActiveTab().getCircuitDiagram() ;
				controller.setState(new DownOnEmptyState( canvasMouseDownEvent.x, canvasMouseDownEvent.y ));
				return;
			}
			
			//// What if there are 2 endpoints in the objects hit array?
			var objectsHit  = canvasMouseDownEvent.objectsHit ;
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
				var endpoint = endpointsHit[0] ;
				controller.setState(new MoveEndpointState( endpoint ));
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
				
				controller.setState(
					new AddToSelectionState(clickedObjects,
											canvasMouseDownEvent.x,
											canvasMouseDownEvent.y));
				return;
			}
		} else {
			// do something
			//trace("Undefined event occured");
		}
	}
}