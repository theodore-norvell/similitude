package controller.controllerState;
import controller.Controller;
import controller.similitudeEvents.AbstractSimilitudeEvent;

/**
 * @author AdvaitTrivedi
 */
interface ControllerStateI 
{
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) : Void;
}