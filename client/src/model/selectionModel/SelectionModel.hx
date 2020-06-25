package model.selectionModel;
import model.component.CircuitElement;
import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;
import model.observe.Observable;
import model.observe.ObservableI;
import model.observe.Observer;
import type.Coordinate;
import type.Set;

/**
 * This class represents a user selection.
 * If the user selects any portion of the Circuit from the UI, this ends up happening.
 * 
 * @author AdvaitTrivedi
 */
class SelectionModel implements Observer extends Observable
{
	var selectedComponents = new Array<Component>();
	var selectedLinks = new Array<Link>();
	var selectedPorts = new Array<Port>();
	var selectedEndpoints = new Array<Endpoint>();

	public function new() {}
	
	public function update(target: ObservableI, ?data:Dynamic) : Void {
		this.notifyObservers(target, data);
	}
	
	/**
	 * Allows a user to add a CircuitElement to the selection.
	 * Will remove a CircuitElement if it already exists in the selection.
	 * Compatible Types : Component, Link, Port, Endpoint.
	 * Will throw a String exception if it is not a compatible type.
	 * @param	element
	 */
	public function toggleCircuitElement(element : CircuitElement) : Void {
		if (Std.is(element, Component)) {
			var component = Std.downcast(element, Component);
			this.containsComponent(component) ? this.removeComponent(component) : this.addComponent(component);
		} else if (Std.is(element, Link)) {
			var link = Std.downcast(element, Link);
			this.containsLink(link) ? this.removeLink(link) : this.addLink(link);
		} else if (Std.is(element, Port)) {
			var port = Std.downcast(element, Port);
			this.containsPort(port) ? this.removePort(port) : this.addPort(port);
		} else if (Std.is(element, Endpoint)) {
			var endpoint = Std.downcast(element, Endpoint);
			this.containsEndpoint(endpoint) ? this.removeEndpoint(endpoint) : this.addEndpoint(endpoint);
		} else {
			throw ("Circuit Element incompatible with types that can be selected. Permitted types are Component, Link, Port, Endpoint. Received :: " + Type.getClassName(Type.getClass(element)));
		}
		this.update(this);
	}
	
	/**
	 * Allows a user to remove a CircuitElement to the selection.
	 * Element will be removed only if the selection contains it.
	 * Compatible Types : Component, Link, Port, Endpoint.
	 * Will throw a String exception if it is not a compatible type.
	 * @param	element
	 */
	public function removeCircuitElement(element : CircuitElement) : Void {
		if (Std.is(element, Component)) {
			if(this.containsComponent(Std.downcast(element, Component))) { this.removeComponent(Std.downcast(element, Component)); }
		} else if (Std.is(element, Link)) {
			if(this.containsLink(Std.downcast(element, Link))) { this.removeLink(Std.downcast(element, Link)); }
		} else if (Std.is(element, Port)) {
			if (this.containsPort(Std.downcast(element, Port))) { this.removePort(Std.downcast(element, Port)); }
		} else if (Std.is(element, Endpoint)) {
			if (this.containsEndpoint(Std.downcast(element, Endpoint))) { this.removeEndpoint(Std.downcast(element, Endpoint)); }
		} else {
			throw ("Circuit Element incompatible with types that can be selected. Permitted types are Component, Link, Port, Endpoint. Received :: " + Type.getClassName(Type.getClass(element)));
		}
		this.update(this);
	}

	public function contains(element : CircuitElement) : Bool {
		if (Std.is(element, Component)) {
			return this.containsComponent(Std.downcast(element, Component)) ;
		} else if (Std.is(element, Link)) {
			 return this.containsLink(Std.downcast(element, Link)) ;
		} else if (Std.is(element, Port)) {
			return this.containsPort(Std.downcast(element, Port)) ;
		} else if (Std.is(element, Endpoint)) {
			return this.containsEndpoint(Std.downcast(element, Endpoint)) ;
		} else {
			throw ("Circuit Element incompatible with types that can be selected. Permitted types are Component, Link, Port, Endpoint. Received :: " + Type.getClassName(Type.getClass(element)));
		}
	}
	
	/**
	 * Will clear the selection completely.
	 * WARNING : only use this function if you know what you are doing.
	 */
	public function clearSelection()  : Void {
		this.selectedComponents = new Array<Component>();
		this.selectedEndpoints = new Array<Endpoint>();
		this.selectedLinks = new Array<Link>();
		this.selectedPorts = new Array<Port>();
		this.update(this);
	}
	
	public function isClear() : Bool {
		return this.selectedComponents.length == 0 && this.selectedEndpoints.length == 0 && this.selectedLinks.length == 0 && this.selectedPorts.length == 0;
	}
	
	/**
	 * will move only components and links, as the endpoints and ports in the selection mostly belong to them.
	 * If needed then implementing a new method with ports and endpoints would be helpful.
	 * @param	differenceX
	 * @param	differenceY
	 */
	public function moveComponentsAndLinks(differenceX: Float, differenceY: Float) : Void {
		for(component in this.selectedComponents) {
			component.set_xPosition(component.get_xPosition() + differenceX);
			component.set_yPosition(component.get_yPosition() + differenceY);
		}
		
		for (link in this.selectedLinks)  {
			var endpoint0 = link.get_endpoint(0);
			var endpoint1 = link.get_endpoint(1);
			endpoint0.moveTo(new Coordinate(endpoint0.get_xPosition() + differenceX, endpoint0.get_yPosition() + differenceY));
			endpoint1.moveTo(new Coordinate(endpoint1.get_xPosition() + differenceX, endpoint1.get_yPosition() + differenceY));
		}
	}
	
	/**
	 * Allows the user of this function to directly place an entire array of components in the selection.
	 * Replaces the old selection of components.
	 * WARNING : Use only if you know what you are doing.
	 * @param	componentArray
	 */
	@:allow(controller.commandManager.ClearSelectionCommand)
	function setSelectedComponents(componentArray: Array<Component>) : Void {
		this.selectedComponents = componentArray;
		this.update(this);
	}
	
	/**
	 * Allows the user of this function to directly place an entire array of link in the selection.
	 * Replaces the old selection of links.
	 * WARNING : Use only if you know what you are doing.
	 * @param	linkArray
	 */
	@:allow(controller.commandManager.ClearSelectionCommand)
	function setSelectedLinks(linkArray: Array<Link>) : Void {
		this.selectedLinks = linkArray;
		this.update(this);
	}
	
	/**
	 * Allows the user of this function to directly place an entire array of ports in the selection.
	 * Replaces the old selection of ports.
	 * WARNING : Use only if you know what you are doing.
	 * @param	portArray
	 */
	@:allow(controller.commandManager.ClearSelectionCommand)
	function setSelectedPorts(portArray: Array<Port>) : Void {
		this.selectedPorts = portArray;
		this.update(this);
	}
	
	/**
	 * Allows the user of this function to directly place an entire array of endpoints in the selection.
	 * Replaces the old selection of endpoints.
	 * WARNING : Use only if you know what you are doing.
	 * @param	endpointArray
	 */
	@:allow(controller.commandManager.ClearSelectionCommand)
	function setSelectedEndpoints(endpointArray: Array<Endpoint>) : Void {
		this.selectedEndpoints = endpointArray;
		this.update(this);
	}
	
	@:allow(controller.commandManager.ClearSelectionCommand)
	function getComponents() : Array<Component> {
		return this.selectedComponents;
	}
	
	public function containsComponent( c : Component ) : Bool {
		return this.selectedComponents.indexOf(c) != -1 ;
	}
	
	@:allow(controller.commandManager.ClearSelectionCommand)
	function getLinks() : Array<Link> {
		return this.selectedLinks;
	}
	
	public function containsLink( link : Link ) : Bool {
		return this.selectedLinks.indexOf( link ) != -1 ;
	}
	
	private function addLink(link: Link) : Void {
		this.selectedLinks.push(link);
	}
	
	private function addComponent(component: Component) : Void {
		this.selectedComponents.push(component);
	}
	
	private function removeLink(link: Link) : Void {
		this.selectedLinks.remove(link);
	}
	
	private function removeComponent(component : Component) : Void {
		this.selectedComponents.remove(component);
	}
	
	private function addPort(port: Port) : Void {
		this.selectedPorts.push(port);
	}
	
	private function removePort(port: Port) : Void {
		this.selectedPorts.remove(port);
	}
	
	public function containsPort(port: Port) : Bool {
		return this.selectedPorts.indexOf(port) != -1;
	}
	
	@:allow(controller.commandManager.ClearSelectionCommand)
	function getPorts() : Array<Port> {
		return this.selectedPorts;
	}
	
	private function addEndpoint(endpoint: Endpoint) : Void {
		this.selectedEndpoints.push(endpoint);
	}
	
	private function removeEndpoint(endpoint: Endpoint) : Void {
		this.selectedEndpoints.remove(endpoint);
	}
	
	public function containsEndpoint(endpoint: Endpoint) : Bool {
		return this.selectedEndpoints.indexOf(endpoint) != -1;
	}
	
	@:allow(controller.commandManager.ClearSelectionCommand)
	function getEndpoint() : Array<Endpoint> {
		return this.selectedEndpoints;
	}
	
	public function getComponentSet() : Set<Component> {
		var componentSet = new Set<Component>(); 
		return componentSet.fromArray(this.selectedComponents);
	}
	
	public function getLinkSet() : Set<Link> {
		var linkSet = new Set<Link>();
		return linkSet.fromArray(this.selectedLinks);
	}
	
	public function onlyComponentsSelected() : Bool {
		return this.getComponents().length > 0 &&
			this.getEndpoint().length == 0 &&
			this.getLinks().length == 0 &&
			this.getPorts().length == 0;
	}
}