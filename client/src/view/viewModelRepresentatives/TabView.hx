package view.viewModelRepresentatives;
import js.html.CanvasElement;
import model.component.CircuitDiagramI;
import model.drawingInterface.Transform;
import model.tabModel.TabModel;
import view.View;


/**
 * ...
 * @author AdvaitTrivedi
 */
class TabView 
{
	public var canvasElement : CanvasElement;
	public var transform: Transform;
	public var view: View;
	public var tabModel: TabModel;
	
	public function new(circuitDiagram: CircuitDiagramI, view: View, tranform: Transform) 
	{
		this.view = view;
		this.tabModel = new TabModel(circuitDiagram);
		this.canvasElement = this.view.spawnNewCanvas();
	}
	
}