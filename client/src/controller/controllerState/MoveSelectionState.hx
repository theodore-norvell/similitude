package controller.controllerState;
import controller.listenerInterfaces.CanvasListener;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;

/**
 * ...
 * @author AdvaitTrivedi
 */
class MoveSelectionState implements ControllerStateI
{

	public function new() 
	{
		
	}
	
	public function operate(canvasListener: CanvasListener, event: CanvasMouseInteractionEvent | AbstractSimilitudeEvent) {}
}