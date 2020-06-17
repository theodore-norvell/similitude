package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class RemoveLinkCommand extends AbstractCommand 
{
	var link: Link;
	
	public function new(circuitDiagram: CircuitDiagramI, link: Link) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.link = link;
	}
	
	override public function execute() : Void {
		trace("Removing this link :: ", this.link);
		this.circuitDiagram.deleteLink(this.link);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		trace("adding this link :: ", this.link);
		this.circuitDiagram.addLink(this.link);
	};
}