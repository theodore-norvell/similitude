package controller.listenerInterfaces;

/**
 * This should be implemented by the controller classes for each element of the UI.
 */
interface ViewListener 
{
	public function update(a: String): Void;
}