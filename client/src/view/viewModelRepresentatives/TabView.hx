package view.viewModelRepresentatives;
import js.html.CanvasElement;
import model.component.CircuitDiagramI;
import model.drawingInterface.Transform;
import model.tabModel.CanvasPan;
import model.tabModel.TabModel;
import view.View;


/**
 * ...
 * @author AdvaitTrivedi
 */
class TabView 
{
	public var canvasElement : CanvasElement;
	public var transform: Transform = Transform.identity();
	public var view: View;
	public var tabModel: TabModel;
	public var canvasPan: CanvasPan = new CanvasPan();
	
	public function new(circuitDiagram: CircuitDiagramI, view: View, tranform: Transform) 
	{
		this.view = view;
		this.tabModel = new TabModel(circuitDiagram);
		this.canvasElement = this.view.spawnNewCanvas();
	}
	
	public function update() {
		var canvas = this.canvasElement ;
		var context = canvas.getContext2d() ;
		context.clearRect(0, 0, canvas.width, canvas.height);
		var drawingAdapter = new DrawingAdapter(this.transform, context);
		this.tabModel.draw(drawingAdapter);
	}
	
	public function panCanvasUp() {
		this.canvasPan.moveYPositive(10);
		this.transform.translate(0, 10);
		this.update();
	}
	
	public function panCanvasDown() {
		this.canvasPan.moveYNegative(10);
		this.transform.translate(0, -10);
		this.update();
	}
	
	public function panCanvasRight() {
		this.canvasPan.moveXPositive(10);
		this.transform.translate(10, 0);
		this.update();
	}
	
	public function panCanvasLeft() {
		this.canvasPan.moveXNegative(10);
		this.transform.translate(-10, 0);
		this.update();
	}
	
	public function panCanvasCentre() {
		this.transform.translate(this.canvasPan.centreX(), this.canvasPan.centreY());
		this.update();
	}
}