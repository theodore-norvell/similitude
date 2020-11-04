package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddLinkCommand extends AbstractCommand implements CommandI
{
	var link: Link;
	
	public function new(circuitDiagram: CircuitDiagramI, link: Link) 
	{
		super(circuitDiagram);
		this.link = link;
	}
	
	public function execute() : Void {
		this.circuitDiagram.addLink(this.link);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.circuitDiagram.deleteLink(this.link);
	};		
}