package controller.listenerInterfaces;
import model.enumeration.ComponentType;

/**
 * @author AdvaitTrivedi
 */
interface CanvasListener extends ViewListener
{
	/**
	 * Performs an add operation through the command manager to add a component onto the canvas
	 * @param	componentToAdd
	 */
	public function addComponentToCanvas(eventObject: Dynamic) : Void;
	public function undoLastCanvasChange() : Void;
}