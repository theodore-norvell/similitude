package controller.listenerInterfaces;
import controller.viewUpdateInterfaces.ViewUpdate;
import model.tabModel.TabModel;

/**
 * This should be implemented by the controller classes for each element of the UI.
 */
interface ViewListener 
{
	public function update(a: String): Void;
	public function setViewUpdater(viewUpdater: ViewUpdate) : Void;
	public function setActiveTab(activeTabModel: TabModel) : Void;
	public function getActiveTab() : TabModel;
}