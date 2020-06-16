package controller.listenerInterfaces;
import controller.commandManager.CommandManager;
import controller.controllerState.ControllerStateI;
import controller.modelManipulationSublayer.ModelManipulationSublayer;
import model.enumeration.ComponentType.ComponentTypes;
import model.similitudeEvents.AbstractSimilitudeEvent;

/**
 * @author AdvaitTrivedi
 */
interface CanvasListener extends ViewListener
{
	public function getCommandManager() : CommandManager;
	public function setState(newState: ControllerStateI) : Void;
	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) : Void;
	public function getComponentTypesSingleton() : ComponentTypes;
	public function getModelManipulator() : ModelManipulationSublayer;
	public function undoLastCanvasChange() : Void;
	public function redoLastCanvasChange() : Void;
}