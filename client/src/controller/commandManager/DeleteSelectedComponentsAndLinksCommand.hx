package controller.commandManager;
import model.component.CircuitDiagramI;
import model.selectionModel.SelectionModel;
import model.component.Component;
import model.component.Link;
import model.component.Port;
import model.component.Endpoint;
import type.Set;

/**
 * @author AdvaitTrivedi
 */
class DeleteSelectedComponentsAndLinksCommand extends AbstractCommand 
{
	var selectionModel: SelectionModel;
	var componentSet: Set<Component>;
	var linkSet: Set<Link>;

	public function new(circuitDiagram: CircuitDiagramI, selectionModel: SelectionModel) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.selectionModel = selectionModel;
		this.componentSet = selectionModel.getComponentSet();
		this.linkSet = selectionModel.getLinkSet();
	}
	
	override public function execute() : Void {
		this.selectionModel.clearSelection();
		
		for (component in this.componentSet) {
			this.circuitDiagram.deleteComponent(component);
		}
		
		for (link in this.linkSet) {
			this.circuitDiagram.deleteLink(link);
		}
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		for (component in this.componentSet) {
			this.circuitDiagram.addComponent(component);
		}
		
		for (link in this.linkSet) {
			this.circuitDiagram.addLink(link);
		}
	};
}