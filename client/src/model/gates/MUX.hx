package model.gates;

import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.drawComponents.DrawMUX;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
import model.selectionModel.SelectionModel ;
/**
 * 2-1 MUX<br>
 * For MUX, the format in the map should be like this:<br>
 * (IO.S, ValueLogic),(IO.INPUT, valueLogic),(IO.INPUT, valueLogic)<br>
 * IO.S must put in the first place<br>
 * Truth Table
 * <br>
 * <pre>
 * ***************************************
 * *|   S   |input 1 | input 2 | output |*<br>
 * *|   0   |   1    |    1    |    1   |*<br>
 * *|   0   |   1    |    0    |    1   |*<br>
 * *|   0   |   0    |    1    |    0   |*<br>
 * *|   0   |   0    |    0    |    0   |*<br>
 * *|   1   |   1    |    1    |    1   |*<br>
 * *|   1   |   1    |    0    |    0   |*<br>
 * *|   1   |   0    |    1    |    1   |*<br>
 * *|   1   |   0    |    0    |    0   |*<br>
 * ***************************************
 *  </pre>
 * @author wanhui
 *
 */
class MUX implements ComponentKind extends AbstractGate implements ComponentKind {
    public function new() {
        super( "MUX") ;
        // TODO add attributes
    }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool, selection : SelectionModel){
        var drawComponent:DrawMUX = new DrawMUX(component, drawingAdapter, highlight);
        drawComponent.drawCorrespondingComponent();
    }
}
