package controller ;

import controller.controllerState.CanvasIdleState;
import controller.controllerState.ControllerStateI;

import controller.viewInterfaces.AttributeViewI ;
import controller.modelManipulationSublayer.ModelManipulator;
import commandManager.CommandManager ;
import model.component.CircuitDiagram;
import model.component.Component;
import model.component.Link;
import model.enumeration.ComponentType;
import model.enumeration.Orientation;
import model.similitudeEvents.AttributeChangeEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.tabModel.TabModel ;
import type.Set;
// import js.html.Console;

/**
 * ...
 * @author ...
 */
class Controller implements ControllerI
{
	var commandManager = new CommandManager();
	var componentTypesSingleton = new ComponentTypes(new CircuitDiagram());
	var state: ControllerStateI = new CanvasIdleState();
	var modelManipulator: ModelManipulator;
	var attributeView: AttributeViewI;
	var activeTab: TabModel;
	
	public function new() 
	{
		this.modelManipulator = new ModelManipulator(this.commandManager);
	}
	
	public function setActiveTab(activeTabModel: TabModel) {
		this.activeTab = activeTabModel;
	}
	
	public function getActiveTab() {
		return this.activeTab;
	}
	
	public function setAttributeView(attributeView: AttributeViewI ) {
		this.attributeView = attributeView;
	}
	
	public function setState(newState: ControllerStateI) : Void {
		this.state = newState;
	}
	
	public function getComponentTypesSingleton() : ComponentTypes {
		return this.componentTypesSingleton;
	}
	
	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) : Void {
		this.state.operate(this, eventObject);
	}
	
	public function getCommandManager() : CommandManager {
		return this.commandManager;
	}
	
	public function getModelManipulator() : ModelManipulator {
		return this.modelManipulator;
	}
	
	public function undoLastCanvasChange() {
		this.commandManager.undoCommand();
	}
	
	public function redoLastCanvasChange() {
		this.commandManager.redoCommand();
	}
	
	public function deleteSelection() {
		this.modelManipulator.checkPoint() ;
		this.modelManipulator.deleteSelection(this.activeTab.getCircuitDiagram(), this.activeTab.getSelectionModel());
		this.modelManipulator.normalise(this.activeTab.getCircuitDiagram()) ;
		this.modelManipulator.checkPoint() ;
	}
	
	public function rotateSelectedComponent() {
		this.modelManipulator.checkPoint() ;
		this.modelManipulator.rotateSelectedComponent(this.activeTab);
		this.modelManipulator.normalise(this.activeTab.getCircuitDiagram()) ;
		this.modelManipulator.checkPoint() ;
	}
	
	/**
	 * Tell the view to show its attributes pane.
	 * TODO The view should use the observer pattern to observe the selection.
	 */
	public function showAttributes() : Void {
		this.attributeView.buildAttributes(this.getActiveTab().getSelectionModel(), false );
	}
	
	
	/**
	 * Tell the view to hide its attributes pane.
	 * TODO The view should use the observer pattern to observe the selection.
	 */
	public function clearAttributes() : Void {
		this.attributeView.clearAttributes();
	}
	
	public function handleAttributeInteractions(eventObject: AttributeChangeEvent) : Void {
		this.modelManipulator.checkPoint() ;
		this.modelManipulator.editAttribute(eventObject.selectionAffected, eventObject.attributeUntyped, eventObject.newAttributeValue );
		this.modelManipulator.normalise(this.activeTab.getCircuitDiagram()) ;
		this.modelManipulator.checkPoint() ;
	}
}
