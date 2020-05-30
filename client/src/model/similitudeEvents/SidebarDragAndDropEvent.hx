package model.similitudeEvents;
import model.enumeration.ComponentType;

/**
 * This is a living class for the Sidebar to canvas drag and drop event
 * @author AdvaitTrivedi
 */
class SidebarDragAndDropEvent extends AbstractSimilitudeEvent
{
	var component: ComponentType;
	public var draggedToX: Float = 0;
	public var draggedToY: Float = 0;

	public function new(component: ComponentType) 
	{
		this.component = component;
		this.eventTypes = EventTypesEnum.SIDEBAR_DRAG_N_DROP;
	}
	
	public function getComponent(): ComponentType {
		return this.component;
	}
}