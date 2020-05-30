package view;

import model.observe.*;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.similitudeEvents.CanvasMouseInteractionEvent;
import model.similitudeEvents.LinkAddEvent;
import model.similitudeEvents.LinkEditEvent;
import type.Coordinate;
import controller.listenerInterfaces.CanvasListener;
import controller.listenerInterfaces.SidebarListener;
import js.Browser.document;
import js.html.CanvasElement;
import js.html.Console;
import js.html.Window;
import haxe.Json;
import model.component.CircuitDiagram;
import view.DrawingAdapter;
import model.similitudeEvents.SidebarDragAndDropEvent;
import model.tabModel.TabModel;
import model.drawingInterface.Transform;
import view.viewModelRepresentatives.TabView;

class View implements Observer
{
	var sidebarListener: SidebarListener;
	var canvasListener: CanvasListener;
	var activeTab: TabView;
	var allTabs = new Array<TabView>();
	/**
	 * Populate the UI using this constructor.
	 */
	public function new() 
	{
		// letting this stay here for now
		// check out the matrix once to understand how it works.
		this.activeTab = new TabView(new CircuitDiagram(), this, Transform.identity());
		this.activeTab.addObserver(this);
		// this.setActiveTab();
		allTabs.push(activeTab);

		document.addEventListener("DOMContentLoaded", function(event) {
		
		// for undo button
		document.querySelector("#undo").addEventListener('click', function (event) {
            // do something
			this.canvasListener.undoLastCanvasChange();
        });
		
		// for redo button
		document.querySelector("#redo").addEventListener('click', function (event) {
            // do something
			this.canvasListener.redoLastCanvasChange();
        });
		
		document.querySelector("#Up").addEventListener('click', function (event) {
            // do something
			this.activeTab.panCanvasUp();
        });
		
		document.querySelector("#Down").addEventListener('click', function (event) {
            // do something
			this.activeTab.panCanvasDown();
        });
		
		document.querySelector("#Left").addEventListener('click', function (event) {
            // do something
			this.activeTab.panCanvasLeft();
        });
		
		document.querySelector("#Right").addEventListener('click', function (event) {
            // do something
			this.activeTab.panCanvasRight();
        });
		
		document.querySelector("#Centre").addEventListener('click', function (event) {
            // do something
			this.activeTab.panCanvasCentre();
        });
    });
	
	}
	
	public function setSidebarListener(listener: SidebarListener){
		this.sidebarListener = listener;
	}
	
	public function setCanvasListener(listener: CanvasListener){
		this.canvasListener = listener;
	}

	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) {
		this.canvasListener.handleCanvasMouseInteractions(eventObject);
	}
	
	/**
	 * This serves a function for the controller to hit as they cannot reach out top the tabView directly
	 */
	public function updateCanvas() : Void {
		this.activeTab.updateTabView();
	}
	
	public function setActiveTab(){
		// do something for the active tab field
		//after that push it to the canvas controller
		this.canvasListener.setActiveTab(this.activeTab.tabModel);
	}
	
	/**
	 * for the observer interface
	 * @param	target
	 * @param	data
	 */
	public function update(target: ObservableI, ?data: Any) : Void {
		this.updateCanvas();
	}
}
