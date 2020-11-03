package controller.controllerState;
import controller.Controller;
import model.similitudeEvents.AbstractSimilitudeEvent;

/**
 * @author AdvaitTrivedi
 */
interface ControllerStateI 
{
	public function operate(controller: Controller, event: AbstractSimilitudeEvent) : Void;
}