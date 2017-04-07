package ;

import com.mun.controller.buttonClick.ButtonClick;
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
        //draw and gate
        cxt = untyped canvas.getContext("2d");
        var scale = Browser.window.devicePixelRatio;

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

        var pixelRatio = (Browser.window.devicePixelRatio || 1)/backingStoreRatioDynamic;
        trace(pixelRatio);


        var drawingAdapter:DrawingAdapterI = new DrawingAdapter(cxt);
        var circuitDiagram:CircuitDiagram = new CircuitDiagram();

//        var component_:ComponentKind = Type.createInstance(Type.resolveClass("com.mun.model.gates.OR"),[]);
////        var and_gate:ComponentKind = new AND();
//        var component__:Component = new Component(250, 50, 40, 40, Orientation.EAST, component_, 2);
////        var drawAnd:DrawComponent = new DrawAND(component__, drawingAdapter);
//        var draw:DrawComponent = Type.createInstance(Type.resolveClass("com.mun.view.drawComponents.DrawOR"),[component__,drawingAdapter]);
//        draw.drawCorrespondingComponent();

//        new CreateAndDraw("OR",250, 50, 40, 40, Orientation.EAST, 3, drawingAdapter);
        new ButtonClick(drawingAdapter);
    }
}
