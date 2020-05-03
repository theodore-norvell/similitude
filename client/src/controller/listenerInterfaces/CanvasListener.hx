package controller.listenerInterfaces;
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
	public function addLinkToCanvas(eventObject: SidebarDragAndDropEvent) : Void;
	public function undoLastCanvasChange() : Void;
	public function redoLastCanvasChange() : Void;
}