package ;

import com.mun.model.component.CircuitDiagram;
import com.mun.model.component.Component;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.Orientation;
import com.mun.model.gates.AND;
import com.mun.model.gates.ComponentKind;
import com.mun.view.drawComponents.DrawAND;
import com.mun.view.drawComponents.DrawComponent;
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
        if(scale == 2){
            canvas.setAttribute("width",Browser.window.innerWidth*2+"");
            canvas.setAttribute("height",Browser.window.innerHeight*2+"");
        }else{
            canvas.setAttribute("width",Browser.window.innerWidth*1+"");
            canvas.setAttribute("height",Browser.window.innerHeight*1+"");
        }

        var drawingAdapter:DrawingAdapterI = new DrawingAdapter(cxt);

        var circuitDiagram:CircuitDiagram = new CircuitDiagram();
        var and_gate:ComponentKind = new AND();

        var component:Component = new Component(60, 50, 40, 40, Orientation.SOUTH, and_gate, 2);
        var drawAnd:DrawComponent = new DrawAND(component, drawingAdapter);
        drawAnd.drawCorrespondingComponent();

    }
}
