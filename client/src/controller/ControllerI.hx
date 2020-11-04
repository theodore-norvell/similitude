package controller;

import model.similitudeEvents.AttributeChangeEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.tabModel.TabModel ;

/** This is the interface that the Controller presents to the view
 * 
 * @author AdvaitTrivedi
 */
interface ControllerI
{
	
	public function setActiveTab(activeTabModel: TabModel) : Void;
	public function getActiveTab() : TabModel;
	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) : Void;
	public function undoLastCanvasChange() : Void;
	public function redoLastCanvasChange() : Void;
	public function deleteSelection() : Void;
	public function rotateSelectedComponent() : Void;
	public function changeAttributeValue(eventObject: AttributeChangeEvent) : Void;
}