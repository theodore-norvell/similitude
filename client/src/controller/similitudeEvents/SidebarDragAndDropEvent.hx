package controller.similitudeEvents;
import model.enumeration.ComponentType;

/**
 * This is a living class for the Sidebar to canvas drag and drop event
 * @author AdvaitTrivedi
 */
class SidebarDragAndDropEvent extends AbstractSimilitudeEvent
{
	var component: ComponentType;
	public var draggedToX: Float ;
	public var draggedToY: Float ;

	public function new(component: ComponentType, x : Float, y : Float ) 
	{
		super( SIDEBAR_DRAG_N_DROP ) ;
		this.component = component;
	}
	
	public function getComponent(): ComponentType {
		return this.component;
	}
}