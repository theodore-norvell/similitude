package controller.controllers;
import controller.controllerState.ControllerStateI;
import controller.viewUpdateInterfaces.ViewUpdate;
import controller.listenerInterfaces.ViewListener;
import js.html.webgl.ActiveInfo;
import model.component.CircuitDiagramI;
import model.tabModel.TabModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractController implements ViewListener
{
	var viewUpdater: ViewUpdate;
	var activeTab: TabModel;
	
	public function setViewUpdater(viewUpdater: ViewUpdate) {
		this.viewUpdater = viewUpdater;
	}
	
	public function setActiveTab(activeTabModel: TabModel) {
		this.activeTab = activeTabModel;
	}
	
	public function getActiveTab() {
		return this.activeTab;
	}
	
	public function update(a: String): Void{}
}