package controller.controllerState;
import controller.commandManager.AddLinkCommand;
import controller.listenerInterfaces.CanvasListener;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;
import model.similitudeEvents.EventTypesEnum;
import model.similitudeEvents.CanvasMouseDownEvent;
import model.component.CircuitElement;

/**
 * ...
 * @author AdvaitTrivedi
 */
class CanvasIdleState implements ControllerStateI
{

	public function new() 
	{
		
	}
	
	public function operate(canvasListener: CanvasListener, event: AbstractSimilitudeEvent) : Void {
		if (event.getEventType() == EventTypesEnum.CANVAS_MOUSE_DOWN) {
			var canvasMouseDownEvent = Std.downcast(event, CanvasMouseDownEvent);
			if (!canvasMouseDownEvent.didObjectsGetHit()) {
				canvasListener.setState(new DownOnEmptyState());
				return; // maybe return the link/endpoint to the controller?
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
				canvasListener.setState(new EditLinkState(endpointsHit[0]));
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
				
				canvasListener.setState(new AddToSelectionState(clickedObjects, canvasMouseDownEvent.xPosition, canvasMouseDownEvent.yPosition));
			}
		} else {
			// do something
			//trace("Undefined event occured");
		}
	}
}