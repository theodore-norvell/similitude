package com.mun.controller.componentUpdate;

import com.mun.type.Coordinate;
import js.html.Element;
import js.Browser;
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import com.mun.view.drawingImpl.Transform;
import com.mun.view.drawingImpl.DrawingAdapter;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.model.component.CircuitDiagramI;
/**
* update the canvas
**/
class UpdateCanvas {
    var circuitDiagram:CircuitDiagramI;
    var transform:Transform;
    var canvas:CanvasElement;
    var context:CanvasRenderingContext2D;

    public function new(circuitDiagram:CircuitDiagramI, canvas:CanvasElement, context:CanvasRenderingContext2D) {
        this.circuitDiagram = circuitDiagram;
        this.transform = Transform.identity();
        this.canvas = canvas;
        this.context = context;

        bindEventListener();
    }

    public function getTransform():Transform{
        return transform;
    }

    public function update(?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        //clear the canvas
        canvas.width = canvas.width;

        circuitDiagram.draw(new DrawingAdapter(transform, context),linkAndComponentArray);
    }


    public function bindEventListener(){
        Browser.document.getElementById("left").onmousedown = left;
        Browser.document.getElementById("right").onmousedown = right;
        Browser.document.getElementById("up").onmousedown = up;
        Browser.document.getElementById("down").onmousedown = down;
        Browser.document.getElementById("zoom_in").onmousedown = zoomIn;
        Browser.document.getElementById("zoom_out").onmousedown = zoomOut;
        Browser.document.getElementById("o").onmousedown = o;
        Browser.document.getElementById("f").onmousedown = f;
    }

    public function unbindEventListener(){
        Browser.document.getElementById("left").removeEventListener("mousedown", left);
        Browser.document.getElementById("right").removeEventListener("mousedown", right);
        Browser.document.getElementById("up").removeEventListener("mousedown", up);
        Browser.document.getElementById("down").removeEventListener("mousedown", down);
        Browser.document.getElementById("zoom_in").removeEventListener("mousedown", zoomIn);
        Browser.document.getElementById("zoom_out").removeEventListener("mousedown", zoomOut);
        Browser.document.getElementById("o").removeEventListener("mousedown", o);
        Browser.document.getElementById("f").removeEventListener("mousedown", f);
    }

    function left(){
        transform = transform.compose(Transform.identity().translate(-com.mun.global.Constant.TRANSFORM_X_DELTA, 0));
        update();
    }
    function right(){
        transform = transform.compose(Transform.identity().translate(com.mun.global.Constant.TRANSFORM_X_DELTA, 0));
        update();
    }
    function up(){
        transform = transform.compose(Transform.identity().translate(0, -com.mun.global.Constant.TRANSFORM_Y_DELTA));
        update();
    }
    function down(){
        transform = transform.compose(Transform.identity().translate(0, com.mun.global.Constant.TRANSFORM_Y_DELTA));
        update();
    }
    function zoomIn(){
        transform = transform.compose(Transform.identity().scale(com.mun.global.Constant.TRANSFORM_ZOOM_IN_RATE, com.mun.global.Constant.TRANSFORM_ZOOM_IN_RATE));
        update();
    }
    function zoomOut(){
        transform = transform.compose(Transform.identity().scale(com.mun.global.Constant.TRANSFORM_ZOOM_OUT_RATE, com.mun.global.Constant.TRANSFORM_ZOOM_OUT_RATE));
        update();
    }
    function o(){
        transform = Transform.identity();
        update();
    }
    function f(){
        var canvasElement:Element = Browser.document.getElementById("canvas-" + circuitDiagram.get_name());

        var styleWidth:String = canvasElement.style.width;
        styleWidth = styleWidth.substring(0, styleWidth.indexOf("p"));

        var styleHeight:String = canvasElement.style.height;
        styleHeight = styleHeight.substring(0, styleHeight.indexOf("p"));

        var width:Float = cast styleWidth;
        var height:Float = cast styleHeight;

        var centerViewCoordinateOfCanvasElement:Coordinate = new Coordinate(width/2, height/2);

        var circuitDiagramCenterWorldCoordinate:Coordinate = circuitDiagram.getComponentAndLinkCenterCoordinate();

        var circuitDiagramWidth:Float = circuitDiagram.get_diagramWidth();
        var circuitDiagramHeight:Float = circuitDiagram.get_diagramHeight();
        var xRation:Float = 1;
        var yRation:Float = 1;

        var screenSize:Float = width > height ? width : height;
        var circuitDiagramSize:Float = circuitDiagramWidth > circuitDiagramHeight ? circuitDiagramWidth : circuitDiagramHeight;

        var scareRation:Float = circuitDiagramSize/screenSize < 1 ? circuitDiagramSize/screenSize : screenSize/circuitDiagramSize;

        transform = Transform.identity().scale(scareRation, scareRation);

        var circuitDiagramCenterViewCoordinate = transform.pointConvert(circuitDiagramCenterWorldCoordinate);

        var xOffset:Float = centerViewCoordinateOfCanvasElement.get_xPosition() - circuitDiagramCenterViewCoordinate.get_xPosition();
        var yOffset:Float = centerViewCoordinateOfCanvasElement.get_yPosition() - circuitDiagramCenterViewCoordinate.get_yPosition();

        transform = transform.translate(xOffset, yOffset);

        update();
    }

}
