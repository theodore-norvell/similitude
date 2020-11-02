package controller.listenerInterfaces;
import controller.commandManager.CommandManager;
import controller.controllerState.ControllerStateI;
import controller.modelManipulationSublayer.ModelManipulator;
import model.enumeration.ComponentType.ComponentTypes;
import model.similitudeEvents.AttributeChangeEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import type.Set;
import model.component.Component;

/**
 * @author AdvaitTrivedi
 */
interface CanvasListener extends ViewListener
{
	
	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) : Void;
	public function undoLastCanvasChange() : Void;
	public function redoLastCanvasChange() : Void;
}