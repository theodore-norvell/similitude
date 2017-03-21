package ;

import com.mun.haxe.drawingImpl.DrawingAdapter;
import com.mun.haxe.drawingInterface.DrawingAdapterI;
import com.mun.haxe.enumeration.Orientation;
import js.Browser;
import js.html.CanvasElement;
import js.html.CanvasRenderingContext2D;
class Test {
    static var canvas:CanvasElement;
    static var cxt:CanvasRenderingContext2D;

    static public function main() {
        trace("Hello World!");
        var button = Browser.document.createButtonElement();
        button.textContent = "Click Me";
        button.onclick = function(event) {
            Browser.alert("Haxe is great");
        }

        Browser.document.body.appendChild(button);
        canvas = cast Browser.document.getElementById("canvas");
        trace(canvas);
        //draw and gate
        cxt = untyped canvas.getContext("2d");
//        var drawComponent:DrawComponent = new DrawComponent(cxt)
        var drawingAdapter : DrawingAdapterI = new DrawingAdapter(cxt);

        drawingAdapter.drawAndShape(60, 50, 40, 40, Orientation.SOUTH);
        drawingAdapter.drawAndShape(110, 50, 40, 40, Orientation.WEST);
        drawingAdapter.drawAndShape(160, 50, 40, 40, Orientation.EAST);
        drawingAdapter.drawAndShape(210, 50, 40, 40, Orientation.NORTH);

        drawingAdapter.drawOrShape(60,  100, 40, 40, Orientation.SOUTH);
        drawingAdapter.drawOrShape(110, 100, 40, 40, Orientation.WEST);
        drawingAdapter.drawOrShape(160, 100, 40, 40,  Orientation.EAST);
        drawingAdapter.drawOrShape(210, 100, 40, 40,  Orientation.NORTH);

        drawingAdapter.drawBufferShape(60,  150, 40, 40, Orientation.SOUTH);
        drawingAdapter.drawBufferShape(110, 150, 40, 40, Orientation.WEST);
        drawingAdapter.drawBufferShape(160, 150, 40, 40,  Orientation.EAST);
        drawingAdapter.drawBufferShape(210, 150, 40, 40,  Orientation.NORTH);

        drawingAdapter.drawNotShape(60,  200, 40, 40, Orientation.SOUTH);
        drawingAdapter.drawNotShape(110, 200, 40, 40, Orientation.WEST);
        drawingAdapter.drawNotShape(160, 200, 40, 40,  Orientation.EAST);
        drawingAdapter.drawNotShape(210, 200, 40, 40,  Orientation.NORTH);

        drawingAdapter.drawRect(60,  250, 40, 40);
        drawingAdapter.drawRect(110, 250, 40, 40);
        drawingAdapter.drawRect(160, 250, 40, 40);
        drawingAdapter.drawRect(210, 250, 40, 40);

        drawingAdapter.drawCricle(60,  300, 10);
        drawingAdapter.drawCricle(110, 300, 10);
        drawingAdapter.drawCricle(160, 300, 10);
        drawingAdapter.drawCricle(210, 300, 10);

        drawingAdapter.drawLine(60,   350, 80, 350);
        drawingAdapter.drawLine(110,  350, 130, 350);
        drawingAdapter.drawLine(160,  350, 190, 350);
        drawingAdapter.drawLine(210,  350, 240, 350);

        drawingAdapter.setTextColor("red");
        drawingAdapter.drawText("1234", 60, 400, 80);

    }
}
