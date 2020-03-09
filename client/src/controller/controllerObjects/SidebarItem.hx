package controller.controllerObjects;

import model.component.Component;
import model.drawingInterface.DrawingAdapterI;

/**
 * ...
 * @author AdvaitTrivedi
 */
class SidebarItem 
{
	var componentToDraw:Component;

	public function new(component: Component) 
	{
		this.componentToDraw = component;
	}
	
	public function drawSidebarItem (drawingAdpater:DrawingAdapterI) {
		// draw the item here.
		// should I also wrap it up in a div here?
		// or maybe let the interfaces handle that?
		
		this.componentToDraw.drawComponent(drawingAdpater, false);
	}
	
}