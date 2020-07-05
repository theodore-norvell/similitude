package controller.controllers;
import controller.commandManager.AddComponentCommand;
import controller.commandManager.AddLinkCommand;
import controller.commandManager.CommandManager;
import controller.commandManager.EditLinkCommand;
import controller.controllerState.CanvasIdleState;
import controller.controllerState.ControllerStateI;
import controller.controllers.AbstractController;
import controller.listenerInterfaces.CanvasListener;
import controller.modelManipulationSublayer.ModelManipulationSublayer;
import model.component.CircuitDiagram;
import model.component.Component;
import model.component.Link;
import model.enumeration.ComponentType;
import model.enumeration.Orientation;
import model.similitudeEvents.AttributeChangeEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import type.Set;
import view.viewUpdaters.AttributeUpdate;
// import js.html.Console;

/**
 * ...
 * @author ...
 */
class CanvasController extends AbstractController implements CanvasListener
{
	var commandManager = new CommandManager();
	var componentTypesSingleton = new ComponentTypes(new CircuitDiagram());
	var state: ControllerStateI = new CanvasIdleState();
	var modelManipulator: ModelManipulationSublayer;
	var attributeUpdater: AttributeUpdate;
	
	public function new() 
	{
		this.modelManipulator = new ModelManipulationSublayer(this.commandManager);
	}
	
	public function setAttributeUpdater(attributeUpdater: AttributeUpdate) {
		this.attributeUpdater = attributeUpdater;
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
	
	public function getModelManipulator() : ModelManipulationSublayer {
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
	 * TODO :: Will change...
	 * @param	componentSet
	 */
	public function showAttributes(componentSet: Set<Component>) {
		this.attributeUpdater.buildAttributes(componentSet.get(0));
	}
	
	public function clearAttributes() {
		this.attributeUpdater.clearAttributes();
	}
	
	public function handleAttributeInteractions(eventObject: AttributeChangeEvent) : Void {
		this.modelManipulator.editAttribute(this.activeTab.getCircuitDiagram(), eventObject);
	}
}
