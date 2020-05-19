package controller.controllerState;
import controller.listenerInterfaces.CanvasListener;
import model.similitudeEvents.AbstractSimilitudeEvent;

/**
 * @author AdvaitTrivedi
 */
interface ControllerStateI 
{
	public function operate(canvasListener: CanvasListener, event: AbstractSimilitudeEvent) : Void;
}