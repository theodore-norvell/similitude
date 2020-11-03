package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AddLinkCommand extends AbstractCommand
{
	var link: Link;
	
	public function new(circuitDiagram: CircuitDiagramI, link: Link) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.link = link;
	}
	
	override public function execute() : Void {
		this.circuitDiagram.addLink(this.link);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.circuitDiagram.deleteLink(this.link);
	};		
}