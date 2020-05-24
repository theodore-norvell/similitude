package controller.listenerInterfaces;
import controller.commandManager.CommandManager;
import controller.controllerState.ControllerStateI;
import model.enumeration.ComponentType.ComponentTypes;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.LinkAddEvent;
import model.similitudeEvents.LinkEditEvent;
import model.similitudeEvents.SidebarDragAndDropEvent;

/**
 * @author AdvaitTrivedi
 */
interface CanvasListener extends ViewListener
{
	public function getCommandManager() : CommandManager;
	public function setState(newState: ControllerStateI) : Void;
	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) : Void;
	public function getComponentTypesSingleton() : ComponentTypes;
	public function undoLastCanvasChange() : Void;
	public function redoLastCanvasChange() : Void;
	public function updateCanvas() : Void;
}