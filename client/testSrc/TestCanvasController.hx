package;
import buddy.* ;
import controller.controllers.CanvasController;
import controller.listenerInterfaces.CanvasListener;
import model.similitudeEvents.SidebarDragAndDropEvent;
import model.tabModel.TabModel;
using buddy.Should;

import assertions.Assert ;
import model.component.* ;
import model.gates.* ;
import model.enumeration.Orientation ;
import model.enumeration.ComponentType;

/**
 * ...
 * @author AdvaitTrivedi
 */
class TestCanvasController extends SingleSuite
{

	public function new() 
	{
		describe("Canvas Controller tests", {
			var canvasController: CanvasListener;
			var tabView: TabView;
			
			beforeEach({
                var tabModel = new TabModel(new CircuitDiagram());
				canvasController = new CanvasController();
				canvasController.setActiveTab(tabModel);
				tabView = new TabView();
            });
			
			it("should add an AND component throough the controller", {
				var eventPassed :SidebarDragAndDropEvent = new SidebarDragAndDropEvent(ComponentType.AND);
				var viewCoord = new Coordinate( 300-83, 300-46) ;
				var worldCoords = tabView.viewToWorld( viewCoord ) ;
				eventPassed.draggedToX = worldCoords.get_xPosition() ;
				eventPassed.draggedToY = worldCoords.get_yPosition() ;
				canvasController.handleCanvasMouseInteractions(eventPassed);
				
				var componentIterator = canvasController.getActiveTab().getCircuitDiagram().get_componentIterator() ;
				componentIterator.hasNext().should.be(true);
				var count = 0;
				for(component in componentIterator) {
					component.getName().should.be("AND");
					count += 1;
				}
				count.should.be(1);
			});
		});
	}
	
}