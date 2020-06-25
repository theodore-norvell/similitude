package controller.commandManager;
import model.component.CircuitDiagramI;
import model.component.Component;

/**
 * ...
 * @author Theo
 */
class RemoveComponentCommand extends AbstractCommand 
{
	var component: Component;
	
	public function new(component: Component) 
	{
		this.setCircuitDiagram(component.get_CircuitDiagram());
		this.component = component;
	}
	
	override public function execute() : Void {
		trace("Removing this component :: ", this.component);
		this.circuitDiagram.deleteComponent(this.component);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		trace("adding this component :: ", this.component);
		this.circuitDiagram.addComponent(this.component);
	};
}