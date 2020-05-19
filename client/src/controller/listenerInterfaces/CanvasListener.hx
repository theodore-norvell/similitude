package controller.listenerInterfaces;
import controller.commandManager.CommandManager;
import controller.controllerState.ControllerStateI;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.LinkAddEvent;
import model.similitudeEvents.LinkEditEvent;
import model.similitudeEvents.SidebarDragAndDropEvent;

/**
 * @author AdvaitTrivedi
 */
interface CanvasListener extends ViewListener
{
	/**
	 * Performs an add operation through the command manager to add a component onto the canvas
	 * 
	 * @param	componentToAdd
	 */
	public function addComponentToCanvas(eventObject: SidebarDragAndDropEvent) : Void;
	public function addLinkToCanvas(eventObject: LinkAddEvent) : Void;
	public function editLinkOnCanvas(eventObject: LinkEditEvent) : Void;
	public function getCommandManager() : CommandManager;
	public function setState(newState: ControllerStateI) : Void;
	public function handleCanvasMouseInteractions(eventObject: CanvasMouseInteractionEvent) : Void;
	public function undoLastCanvasChange() : Void;
	public function redoLastCanvasChange() : Void;
	public function updateCanvas() : Void;
}