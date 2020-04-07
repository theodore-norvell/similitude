package model.gates;

import model.drawComponents.DrawAND;
import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.selectionModel.SelectionModel ;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
/**
 * AND gate<br>
 * Truth Table
 * <br>
 * <pre>
 * *******************************
 * *|input 1 | input 2 | output |*<br>
 * *|   1    |    1    |    1   |*<br>
 * *|   0    |    1    |    0   |*<br>
 * *|   1    |    0    |    0   |*<br>
 * *|   0    |    0    |    0   |*<br>
 * *******************************
 *  </pre>
 * @author wanhui
 *
 */
class AND implements ComponentKind extends AbstractGate implements ComponentKind{


    var nameOfTheComponentKind:String="AND";

    public function new() {
        super() ;
    }


    public function getname():String{
        return nameOfTheComponentKind;
    }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool, selection : SelectionModel ){
        var drawComponent:DrawAND = new DrawAND(component, drawingAdapter, highlight);
        drawComponent.drawCorrespondingComponent();
    }

}
