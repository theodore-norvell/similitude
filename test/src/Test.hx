package ;

import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.controller.componentUpdate.UpdateCanvas;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
import com.mun.controller.mouseAction.CanvasListener;
import com.mun.controller.mouseAction.ButtonClick;
import com.mun.model.component.CircuitDiagram;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.view.drawingImpl.DrawingAdapter;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
class Test {
    static var canvas:CanvasElement;
    static var cxt:CanvasRenderingContext2D;

    static public function main() {
        canvas = cast Browser.document.getElementById("canvas");
        cxt = untyped canvas.getContext("2d");

        var backingStoreRatioDynamic : Dynamic = Reflect.field( cxt, "webKitBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( cxt, "mozBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( cxt, "msBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( cxt, "oBackingStorePixelRatio" ) ;
        if( backingStoreRatioDynamic == null )
            backingStoreRatioDynamic = Reflect.field( cxt, "backingStorePixelRatio" ) ;
        var backingStoreRatio : Float =
        if( backingStoreRatioDynamic == null ) 1.0
        else cast( backingStoreRatioDynamic, Float ) ;

        var pixelRatio:Int = cast Browser.window.devicePixelRatio/backingStoreRatio;
        var oldWidth:Int = cast Browser.window.innerWidth * 0.9;
        var oldHeight:Int =cast Browser.window.innerHeight * 0.9;
        canvas.width = oldWidth * pixelRatio;
        canvas.height = oldHeight * pixelRatio;
        canvas.style.width = oldWidth + 'px';
        canvas.style.height = oldHeight + 'px';
        // now scale the context to counter
        // the fact that we've manually scaled
        // our canvas element
        cxt.scale(pixelRatio, pixelRatio);

        var drawingAdapter:DrawingAdapterI = new DrawingAdapter(cxt);

        var circuitDiagram:CircuitDiagram = new CircuitDiagram();



        var updateCanvas:UpdateCanvas = new UpdateCanvas(canvas,circuitDiagram,drawingAdapter);
        var updateToolBar:UpdateToolBar = new UpdateToolBar(circuitDiagram, updateCanvas);
        var updateCircuitDiagram:UpdateCircuitDiagram = new UpdateCircuitDiagram(circuitDiagram,updateCanvas,updateToolBar);

        //add button click listener
        new ButtonClick(drawingAdapter,updateCircuitDiagram,pixelRatio);
        //add canvas listener
        new CanvasListener(canvas,updateCircuitDiagram,updateToolBar);

    }


}
