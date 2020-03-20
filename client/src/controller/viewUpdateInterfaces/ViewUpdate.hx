package controller.viewUpdateInterfaces;

/**
 * @author ...
 */
interface ViewUpdate extends CanvasUpdate extends SidebarUpdate
{
	public function updateView(string: String): Void;
}