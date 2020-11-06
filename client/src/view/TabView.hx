package view ;
import model.observe.* ;
import controller.similitudeEvents.CanvasMouseDownEvent;
import controller.similitudeEvents.CanvasMouseMoveEvent;
import controller.similitudeEvents.CanvasMouseUpEvent;
import controller.similitudeEvents.SidebarDragAndDropEvent;
import type.Coordinate;
import js.html.CanvasElement;
import js.html.DragEvent ;
import js.html.Event ;
import js.html.MouseEvent ;
import model.component.CircuitDiagramI;
import model.drawingInterface.Transform;
import model.tabModel.TabModel;
import view.View;
import haxe.Unserializer;
import js.Browser.document;
import model.enumeration.MODE;
import view.drawingImpl.DrawingAdapter;

/**
 * ...
 * @author AdvaitTrivedi
 */
class TabView implements Observer extends Observable
{
	private var canvasElement : CanvasElement;
	private var transform: Transform = Transform.identity();
	private var view: View;
	public var tabModel: TabModel;
	
	public function new(circuitDiagram: CircuitDiagramI, view: View, tranform: Transform) 
	{
		this.view = view;
		this.tabModel = new TabModel(circuitDiagram);
		this.tabModel.addObserver(this);
		this.canvasElement = this.spawnNewCanvas();
	}

	public function viewToWorld( viewCoord : Coordinate ) : Coordinate {
		return transform.pointInvert( viewCoord ) ;
	}
	
	public function update(target: ObservableI, ?data:Dynamic) : Void {
		this.notifyObservers(target, data);
	}
	
	public function updateTabView() {
		var canvas = this.canvasElement ;
		var context = canvas.getContext2d() ;
		context.clearRect(0, 0, canvas.width, canvas.height);
		var drawingAdapter = new DrawingAdapter(this.transform, context);
		this.tabModel.draw(drawingAdapter);
	}
	
	public function panCanvasUp() {
		this.transform = this.transform.translate(0, -70);
		this.updateTabView();
	}
	
	public function panCanvasDown() {
		this.transform = this.transform.translate(0, 70);
		this.updateTabView();
	}
	
	public function panCanvasRight() {
		this.transform = this.transform.translate(70, 0);
		this.updateTabView();
	}
	
	public function panCanvasLeft() {
		this.transform = this.transform.translate(-70, 0);
		this.updateTabView();
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
		this.updateTabView();
	}
	
	private function spawnNewCanvas() : CanvasElement {
		// TODO.  It seems to me (TSN) that this routine should be moved to the TabView class.
		var canvasDisplayScreen = document.querySelector("#displayScreen");
		
		var innerCanvas = document.createCanvasElement();
		// innerCanvas.id = "canvasToDraw"; // deal with this to get better and unique IDs, IF NEED BE
		canvasDisplayScreen.appendChild(innerCanvas);
		var cs = document.defaultView.getComputedStyle(canvasDisplayScreen);
		
		innerCanvas.style.width = "100%";
		innerCanvas.style.height = "100%";
		innerCanvas.style.border = "solid 1px black";
		innerCanvas.width = Std.parseInt(cs.getPropertyValue('width'));
		innerCanvas.height = Std.parseInt(cs.getPropertyValue('height'));
		
		// needs this event by default for the drop target.
		canvasDisplayScreen.addEventListener('dragover', function (event : DragEvent ) {
			event.preventDefault(); // called to avoid any other event from occuring when processing this one.
			event.dataTransfer.dropEffect = "move";
			// refer to MDN docs for more dropEffects
			
		});
		
		// needs this event by default for the drop target.
		canvasDisplayScreen.addEventListener('drop', function ( event : DragEvent ) {
			event.preventDefault();
			var data = event.dataTransfer.getData("text/plain");
			var eventPassed :SidebarDragAndDropEvent = Unserializer.run(data);
			var viewCoord = getCoordsRelativeToCanvasXY( event.clientX, event.clientY ) ;
			var worldCoords = viewToWorld( viewCoord ) ;
			eventPassed.draggedToX = worldCoords.get_xPosition() ;
			eventPassed.draggedToY = worldCoords.get_yPosition() ;
			trace(eventPassed);
			//eventPassed.draggedToX = event.pageX;
			//eventPassed.draggedToY = event.pageY;
			this.view.handleCanvasMouseInteractions(eventPassed);
		});
		
		innerCanvas.onmousedown = function (event : MouseEvent ) {
			var circuitDiagram = this.tabModel.getCircuitDiagram();
			
			var viewCoord = getCoordsRelativeToCanvas( event ) ;
			var worldCoords = viewToWorld( viewCoord );
			var objectsHit = circuitDiagram.findHitList(worldCoords, MODE.INCLUDE_PARENTS);
			var x = worldCoords.get_xPosition();
			var y = worldCoords.get_yPosition();
			var eventPassed = new CanvasMouseDownEvent(x, y, objectsHit);
			this.view.handleCanvasMouseInteractions(eventPassed);
		}
		
		innerCanvas.onmousemove = function (event : MouseEvent) {
			var circuitDiagram = this.tabModel.getCircuitDiagram();
			
			// the magic numbers are canvas offsets to stabilize the position of the element placed on the canvas
			var viewCoord = getCoordsRelativeToCanvas( event ) ;
			var worldCoords = viewToWorld( viewCoord );
			var objectsHit = circuitDiagram.findHitList(worldCoords, MODE.INCLUDE_PARENTS);
			var x = worldCoords.get_xPosition();
			var y = worldCoords.get_yPosition();
			var eventPassed = new CanvasMouseMoveEvent(x, y, objectsHit);
			this.view.handleCanvasMouseInteractions(eventPassed);
		}
		
		innerCanvas.onmouseup = function (event : MouseEvent) {
			var circuitDiagram = this.tabModel.getCircuitDiagram();
			
			var viewCoord = getCoordsRelativeToCanvas( event ) ;
			var worldCoords = getCoordsRelativeToCanvas( event ) ;
			var objectsHit = circuitDiagram.findHitList(worldCoords, MODE.INCLUDE_PARENTS);
			var x = worldCoords.get_xPosition();
			var y = worldCoords.get_yPosition();
			var eventPassed = new CanvasMouseUpEvent(x, y, objectsHit);
			this.view.handleCanvasMouseInteractions(eventPassed);
		}
		
		return innerCanvas;
	}

	private function getCoordsRelativeToCanvasXY( clientX : Float, clientY : Float ) : Coordinate {
		// See https://stackoverflow.com/questions/17130395/real-mouse-position-in-canvas
		// especially answer by Rafel S.
		var rect = canvasElement.getBoundingClientRect();
		var x = (clientX - rect.left) / (rect.right - rect.left) * canvasElement.width ;
		var y = (clientY - rect.top) / (rect.bottom - rect.top) * canvasElement.height ;
		return new Coordinate( x,  y) ;
	}

	private function getCoordsRelativeToCanvas( evt : MouseEvent ) : Coordinate {
		return getCoordsRelativeToCanvasXY( evt.clientX, evt.clientY ) ;
	}
}