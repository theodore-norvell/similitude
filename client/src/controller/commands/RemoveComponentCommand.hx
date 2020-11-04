package controller.commands ;

import commandManager.CommandI ;
import model.component.CircuitDiagramI;
import model.component.Component;

/**
 * ...
 * @author Theo
 */
class RemoveComponentCommand extends AbstractCommand  implements CommandI
{
	var component: Component;
	
	public function new(component: Component) 
	{
		super(component.get_CircuitDiagram());
		this.component = component;
	}
	
	public function execute() : Void {
		trace("Removing this component :: ", this.component);
		this.circuitDiagram.deleteComponent(this.component);
	}
	
	public function redo() : Void {
		this.execute();
	}
	
	public function undo() : Void {
		trace("adding this component :: ", this.component);
		this.circuitDiagram.addComponent(this.component);
	};
}