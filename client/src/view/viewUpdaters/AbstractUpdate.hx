package view.viewUpdaters;
import controller.viewUpdateInterfaces.ViewUpdate;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractUpdate implements ViewUpdate
{
	var viewToUpdate: View;
	
	public function setViewToUpdate(view: View){
		this.viewToUpdate = view;
	}
	
	public function updateView(string: String): Void {};
	public function updateCanvas(): Void {};
	
}