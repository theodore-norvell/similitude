package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Component;
import model.similitudeEvents.CanvasPanEvent;

/**
 * ...
 * @author AdvaitTrivedi
 */
class PanCanvasCommand extends AbstractCommand
{
	var canvasPanEvent: CanvasPanEvent;

	public function new(circuitDiagram: CircuitDiagramI, canvasPanEvent: CanvasPanEvent) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.canvasPanEvent = canvasPanEvent;
	}
	
	override public function execute() : Void {
		var componentIterator = this.circuitDiagram.get_componentIterator();
		if (componentIterator.hasNext()) {
			do {
				//trace(componentIterator.next());
				var component: Component = componentIterator.next();
				// the plus sign stands for the fact that the pan is properly set as negative or positive and the command object does not have to worry about it.
				component.set_xPosition(component.get_xPosition() + canvasPanEvent.xPan);
				component.set_yPosition(component.get_yPosition() + canvasPanEvent.yPan);
			} while (!componentIterator.hasNext());
		}
		// do this for links too...
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		var componentIterator = this.circuitDiagram.get_componentIterator();
		if (componentIterator.hasNext()) {
			do {
				var component: Component = componentIterator.next();
				// the negative sign stands for the fact that the pan is properly set as negative or positive and the command object does not have to worry about it.
				component.set_xPosition(component.get_xPosition() - canvasPanEvent.xPan);
				component.set_yPosition(component.get_yPosition() - canvasPanEvent.yPan);
			} while (!componentIterator.hasNext());
		}
		// do this for links too...
	}
	
}