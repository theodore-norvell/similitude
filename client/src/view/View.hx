package view;

import haxe.Int64;
import model.observe.*;
import model.similitudeEvents.AttributeChangeEvent;
import model.similitudeEvents.AbstractSimilitudeEvent;
import model.values.SignalValue;
import model.values.instantaneousValues.displayStrategies.InstantaneousStratFactorySingletons;
import model.values.instantaneousValues.scalarValues.ScalarValueSingletons;
import controller.listenerInterfaces.CanvasListener;
import js.Browser.document;
import js.html.CanvasElement;
import model.component.CircuitDiagram;
import type.TimeUnit;
import model.drawingInterface.Transform;
import view.drawingImpl.SignalDrawingAdapater;
import view.viewModelRepresentatives.TabView;

class View implements Observer
{
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
			
			document.querySelector("#delete").addEventListener('click', function (event) {
				// do something
				this.canvasListener.deleteSelection();
			});
			
			document.querySelector("#rotate").addEventListener('click', function (event) {
				// do something
				this.canvasListener.rotateSelectedComponent();
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
			
			//// TEST :: USING VALUES from the model
			//var simulationCanvas = Std.downcast(document.querySelector("#simulationCanvas"), CanvasElement);
			//
			//var signalDrawingAdapter = new SignalDrawingAdapater(Transform.identity(), simulationCanvas.getContext2d());
			//
			//// create signal with a time unit for magnification, can change the unit later.
			//var signal = new SignalValue();
			//
			//// Simple cascading wave
			//signal.setValueAtTime(Int64.ofInt(0), Int64.ofInt(5), ScalarValueSingletons.HIGH);
			//signal.setValueAtTime(Int64.ofInt(6), Int64.ofInt(10), ScalarValueSingletons.LOW);
			//signal.setValueAtTime(Int64.ofInt(11), Int64.ofInt(15), ScalarValueSingletons.HIGH);
			//
			//// only firstAffectedFrame (the reverse case is not possible and should be deemed wrong)
			//signal.setValueAtTime(Int64.ofInt(12), Int64.ofInt(17), ScalarValueSingletons.LOW);
			//
			//// for adjacent first and last affected (Really?)
			//signal.setValueAtTime(Int64.ofInt(4), Int64.ofInt(8), ScalarValueSingletons.HIGH);
			//
			////more frames between first and last affected, and this marks only lastAffectedFrame too.
			//signal.setValueAtTime(Int64.ofInt(9), Int64.ofInt(13), ScalarValueSingletons.HIGH);
						//
			////draw the signal
			//signal.draw(signalDrawingAdapter, InstantaneousStratFactorySingletons.DIGITAL_WAVE_FACTORY, 20, 20);
  	  });
	
	}
	
	public function setCanvasListener(listener: CanvasListener){
		this.canvasListener = listener;
	}

	public function handleCanvasMouseInteractions(eventObject: AbstractSimilitudeEvent) {
		this.canvasListener.handleCanvasMouseInteractions(eventObject);
	}
	
	public function handleAttributeInteractions(eventObject: AttributeChangeEvent) {
		this.canvasListener.handleAttributeInteractions(eventObject);
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
