package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class RemoveLinkCommand extends AbstractCommand  implements CommandI
{
	var link: Link;
	
	public function new(link: Link) 
	{
		super(link.getCircuitDiagram());
		this.link = link;
	}
	
	public function execute() : Void {
		trace("Removing this link :: ", this.link);
		this.circuitDiagram.deleteLink(this.link);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		trace("adding this link :: ", this.link);
		this.circuitDiagram.addLink(this.link);
	};
}