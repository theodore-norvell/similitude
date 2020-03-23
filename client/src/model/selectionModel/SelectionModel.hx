package model.selectionModel;
import model.component.Component;
import model.component.Link;

/**
 * ...
 * @author AdvaitTrivedi
 */
class SelectionModel 
{
	var selectedComponents: Array<Component>;
	var selectedLinks: Array<Link>;

	public function new(linkArray:Array<Link>, componentArray:Array<Component>) 
	{
		this.selectedComponents = componentArray;
		this.selectedLinks = linkArray;
	}
	
	public function getSelectedComponents() : Array<Component> {
		return this.selectedComponents;
	}
	
	public function containsComponent( c : Component ) : Bool {
		return this.selectedComponents.indexOf(c) != -1 ;
	}
	
	public function getSelectedLinks() : Array<Link> {
		return this.selectedLinks;
	}
	
	public function containsLink( lnk : Link ) : Bool {
		return this.selectedLinks.indexOf( lnk ) != -1 ;
	}
	
	public function addLinkToSelection(link: Link) : Void {
		this.selectedLinks.push(link);
	}
	
	public function addComponentToSelection(component: Component) : Void {
		this.selectedComponents.push(component);
	}
	
	public function removeLinkFromSelection(link: Link) : Void {
		this.selectedLinks.remove(link);
	}
	
	public function removeComponentFromSelection(component : Component) : Void {
		this.selectedComponents.remove(component);
	}
}