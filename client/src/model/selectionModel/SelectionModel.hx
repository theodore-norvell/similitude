package model.selectionModel;
import model.component.Component;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class SelectionModel 
{
	var selectedComponents: List<Component>;
	var selectedLinks: List<Link>;

	public function new(linkArray:List<Link>, componentArray:List<Component>) 
	{
		this.selectedComponents = componentArray;
		this.selectedLinks = linkArray;
	}
	
	public function getSelectedComponents() : List<Component> {
		return this.selectedComponents;
	}
	
	public function getSelectedComponents() : List<Component> {
		return this.selectedLinks;
	}
}