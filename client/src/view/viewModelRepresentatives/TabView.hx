package view.viewModelRepresentatives;
import type.Coordinate;
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

	public function viewToWorld( viewCoord : Coordinate ) : Coordinate {
		return transform.pointInvert( viewCoord ) ;
	}
	
	public function update() {
		var canvas = this.canvasElement ;
		var context = canvas.getContext2d() ;
		context.clearRect(0, 0, canvas.width, canvas.height);
		var drawingAdapter = new DrawingAdapter(this.transform, context);
		this.tabModel.draw(drawingAdapter);
	}
	
	public function panCanvasUp() {
		this.canvasPan.moveY(-10);
		this.transform = this.transform.translate(0, -10);
		this.update();
	}
	
	public function panCanvasDown() {
		this.canvasPan.moveY(10);
		this.transform = this.transform.translate(0, 10);
		this.update();
	}
	
	public function panCanvasRight() {
		this.canvasPan.moveX(10);
		this.transform = this.transform.translate(10, 0);
		this.update();
	}
	
	public function panCanvasLeft() {
		this.canvasPan.moveX(-10);
		this.transform = this.transform.translate(-10, 0);
		this.update();
	}
	
	public function panCanvasCentre() {
		var circuitLeft  = this.tabModel.getCircuitDiagram().get_xMin() ;
		var circuitTop  = this.tabModel.getCircuitDiagram().get_yMin() ;
		var circuitWidth = Math.max( 1, this.tabModel.getCircuitDiagram().get_diagramWidth() ) ;
		var circuitHeight = Math.max( 1, this.tabModel.getCircuitDiagram().get_diagramHeight() ) ;
		var circuitCentreX = circuitLeft + circuitWidth/2 ;
		var circuitCentreY = circuitTop + circuitHeight/2 ;
		// The scale should convert distances
		var canvWidth = canvasElement.width ;
		var canvHeight = canvasElement.height ;
		var xScale =  canvWidth / circuitWidth ;
		var yScale = canvHeight / circuitHeight ;
		var scale = Math.min( xScale, yScale ) ;
		// The centre of the circuit should be translated to the origin.
		// Then the diagram is scaled to view size.
		// Finally the center origin is translated to the centre of the canvas.
		this.transform = Transform.identity() ;
		this.transform = this.transform.translate( -circuitCentreX, -circuitCentreY ) ;
		this.transform = this.transform.scale( scale, scale ) ;
		this.transform = this.transform.translate( canvWidth/2, canvHeight/2 ) ;
		this.update();
	}
}