package model.gates;


import model.component.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.selectionModel.SelectionModel ;
import model.component.*;
import model.enumeration.IOTYPE;
import model.enumeration.Orientation;
/**
 * NOT gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *********************
 * *|input 1 | output |*<br>
 * *|   1    |    0   |*<br>
 * *|   0    |    1   |*<br>
 * *********************
 *  </pre>
 * @author wanhui
 *
 */
class NOT implements ComponentKind extends AbstractGate implements ComponentKind {

    public function new() {
        super("NOT") ;
    }

    override function initialNumberOfInPorts() : Int { return 1 ; }
    override function minimumNumberOfInPorts() : Int { return 1 ; }

    override function maximumNumberOfInPorts() : Int { return 1 ; }
    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highLight:Bool, selection : SelectionModel){
        DrawComponent.drawNot(component, drawingAdapter, highLight);
    }
}
