package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Connection;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DisconnectLinkCommand extends AbstractCommand  implements CommandI
{
	var link: Link;
	var connection0: Connection;
	var connection1: Connection;

	public function new(link: Link) 
	{
		super( link.get_CircuitDiagram() ) ;
		this.link = link;
	}
	
	public function execute() : Void {
		this.connection0 = this.link.get_endpoint(0).getConnection();
		this.link.get_endpoint(0).disconnect();
		this.connection1 = this.link.get_endpoint(1).getConnection();
		this.link.get_endpoint(1).disconnect();
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		this.connection0.connect(this.link.get_endpoint(0));
		this.connection1.connect(this.link.get_endpoint(1));
	};
}