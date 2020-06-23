package controller.commandManager;
import model.component.CircuitDiagramI;
import model.selectionModel.SelectionModel;
import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;

/**
 * ...
 * @author AdvaitTrivedi
 */
class DeleteSelectionCommand extends AbstractCommand 
{
	var selectionModel: SelectionModel;
	var selectedComponents = new Array<Component>();
	var selectedLinks = new Array<Link>();
	var selectedPorts = new Array<Port>();
	var selectedEndpoints = new Array<Endpoint>();

	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		this.selectedComponents = selectionModel.getComponents();
		this.selectedLinks = selectionModel.getLinks();
		this.selectedPorts = selectionModel.getPorts();
		this.selectedEndpoints = selectionModel.getEndpoint();
	}
	
	override public function execute() : Void {
		this.selectionModel.clearSelection();
		
		for (component in this.selectedComponents) {
			this.circuitDiagram.deleteComponent(component);
		}
		
		for (link in this.selectedLinks) {
			this.circuitDiagram.deleteLink(link);
		}
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		this.selectionModel.setSelectedComponents(this.selectedComponents);
		this.selectionModel.setSelectedEndpoints(this.selectedEndpoints);
		this.selectionModel.setSelectedLinks(this.selectedLinks);
		this.selectionModel.setSelectedPorts(this.selectedPorts);
		
		for (component in this.selectedComponents) {
			this.circuitDiagram.addComponent(component);
		}
		
		for (link in this.selectedLinks) {
			this.circuitDiagram.addLink(link);
		}
	};
}