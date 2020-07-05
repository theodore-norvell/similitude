package controller.controllers;
import controller.viewUpdateInterfaces.ViewUpdate;
import controller.listenerInterfaces.ViewListener;
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