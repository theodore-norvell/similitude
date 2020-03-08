package view.viewUpdaters;
import view.viewUpdaters.AbstractUpdate;
/**
 * Class in charge of handling the updates sent by the controller to the UI.
 * It willl ensure pushing changes to the UI, through the View class it can access.
 */
class SidebarUpdate extends AbstractUpdate
{
	
	public function new(view: View){
		super.setViewToUpdate(view);
	}
	
	public override function updateView(string: String){
		this.viewToUpdate.updateThisBox(string);
	}
	
}