package model.similitudeEvents;
import model.enumeration.ComponentType;

/**
 * This is a living class for the Sidebar to canvas drag and drop event
 * @author AdvaitTrivedi
 */
class SidebarDragAndDropEvent extends AbstractSimilitudeEvent
{
	public var component: ComponentType;
	public var draggedToX: Int = 0;
	public var draggedToY: Int = 0;

	public function new() 
	{
		
	}
}