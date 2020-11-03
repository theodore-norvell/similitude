package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Connection;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DisconnectLinkCommand extends AbstractCommand 
{
	var link: Link;
	var connection0: Connection;
	var connection1: Connection;

	public function new(link: Link) 
	{
		this.link = link;
	}
	
	override public function execute() : Void {
		this.connection0 = this.link.get_endpoint(0).getConnection();
		this.link.get_endpoint(0).disconnect();
		this.connection1 = this.link.get_endpoint(1).getConnection();
		this.link.get_endpoint(1).disconnect();
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.connection0.connect(this.link.get_endpoint(0));
		this.connection1.connect(this.link.get_endpoint(1));
	};
}