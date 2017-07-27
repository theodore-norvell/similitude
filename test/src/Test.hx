package ;

import com.mun.controller.controllerState.FolderState;
import com.mun.model.component.Folder;
import com.mun.model.component.FolderI;
import com.mun.controller.controllerState.SideBar;
import com.mun.controller.controllerState.ControllerCanvasContext;
import com.mun.global.Constant.*;
import com.mun.model.component.CircuitDiagram;
import com.mun.model.component.CircuitDiagramI;
import com.mun.controller.componentUpdate.UpdateToolBar;
import com.mun.controller.componentUpdate.UpdateCanvas;
import com.mun.controller.componentUpdate.UpdateCircuitDiagram;
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
        var oldWidth:Int = cast Browser.window.innerWidth * 0.81;
        var oldHeight:Int =cast Browser.window.innerHeight * 0.81;
        canvas.width = oldWidth * pixelRatio;
        canvas.height = oldHeight * pixelRatio;
        canvas.style.width = oldWidth + 'px';
        canvas.style.height = oldHeight + 'px';
        // now scale the context to counter
        // the fact that we've manually scaled
        // our canvas element
        cxt.scale(pixelRatio, pixelRatio);

        CONTEXT = cxt;
        PIXELRATIO = pixelRatio;
        CANVAS = canvas;

        var folderState:FolderState = new FolderState();
//        var folder:FolderI = new Folder();
//
//        var circuitDiagram:CircuitDiagramI = folder.createNewCircuitDiagram();
//
//
//        var updateCircuitDiagram:UpdateCircuitDiagram = new UpdateCircuitDiagram(circuitDiagram);
//        circuitDiagram.set_commandManager(updateCircuitDiagram.get_commandManager());
//
//        var updateToolBar:UpdateToolBar = new UpdateToolBar(updateCircuitDiagram);
//        updateCircuitDiagram.setUpdateToolBar(updateToolBar);
//
//        var updateCanvas:UpdateCanvas = new UpdateCanvas(canvas, circuitDiagram, updateCircuitDiagram.get_transform());
//        updateCircuitDiagram.setUpdateCanvas(updateCanvas);
//
//        var sideBar = new SideBar(updateCircuitDiagram);
//
//        var controllerCanvasContext:ControllerCanvasContext = new ControllerCanvasContext(canvas, circuitDiagram, updateCircuitDiagram, sideBar, updateToolBar);
//        sideBar.setControllerCanvasContext(controllerCanvasContext);
    }


}
