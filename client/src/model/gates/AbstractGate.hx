package model.gates;

import model.attribute.Attribute;
import model.attribute.OrientationAttr;
import model.attribute.StringAttr;
import model.attribute.IntAttr;
import model.drawComponents.DrawAND;
import model.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import model.selectionModel.SelectionModel ;
import model.component.Component ;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
 /**
  * A parent class for gates and gate-like things.
  * 
  */
class AbstractGate extends AbstractComponentKind {

    public function new() {
        super() ;
        attributes.push(new IntAttr("delay"));
    }

}
