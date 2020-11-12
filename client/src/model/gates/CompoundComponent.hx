package model.gates;

import model.selectionModel.SelectionModel;
import assertions.Assert ;
import model.observe.Observable;
import model.observe.Observer;
import type.HitObject;
import type.WorldPoint;

import model.component.CircuitDiagramI;
import model.component.Component ;
import model.enumeration.POINT_MODE;
import model.enumeration.Box;
import model.enumeration.IOTYPE;
import model.enumeration.MODE;
import type.Coordinate;
import model.drawingInterface.Transform;
import model.drawingInterface.DrawingAdapterI;
import model.component.Component;
import model.enumeration.Orientation;
import model.component.Port;
/**
* compound Component
**/
class CompoundComponent implements ComponentKind extends AbstractComponentKind{
    var Ob:Observer;
    var Obable:Observable;
    var circuitDiagram:CircuitDiagramI;

    public function new(circuitDiagram:CircuitDiagramI) {
        super("Compound") ;
        this.circuitDiagram = circuitDiagram;
    }

    override public function getInnerCircuitDiagram():CircuitDiagramI{
        return circuitDiagram;
    }

    public function createPorts( component : Component ) : Void {
        // This needs more thought.  For now I'm just going to make two ports.
        var port0 = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        port0.set_portDescription( IOTYPE.OUTPUT ) ;
        component.addPort( port0 ) ;

        var port1 = new Port( component.get_CircuitDiagram(), 0, 0 ) ;
        port1.set_portDescription( IOTYPE.INPUT ) ;
        component.addPort( port1 ) ;
    }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool,  selection : SelectionModel ):Void {
        var drawingAdapterTrans:DrawingAdapterI = drawingAdapter.transform(makeTransform(component));
        DrawingUtility.drawCompoundComponent( component, drawingAdapter, highlight, drawingAdapterTrans ) ;

        if(component.get_boxType() == Box.WHITE_BOX){
            // Draw the inside of the circuit.
            circuitDiagram.draw(drawingAdapterTrans, selection);
            DrawingUtility.connectPortsToConnectors(component, drawingAdapter, highlight, drawingAdapterTrans) ;
        }
    }

    function makeTransform(component : Component ):Transform{
        var transform:Transform = Transform.identity();
        var centre = circuitDiagram.get_centre() ;
        transform = transform.translate(-centre.get_xPosition(), -centre.get_yPosition())
                    .scale(component.get_width()/circuitDiagram.get_diagramWidth(), component.get_height()/circuitDiagram.get_diagramHeight())
                    .translate(component.get_xPosition(), component.get_yPosition());

        return transform;
    }

    override public function findHitList(component : Component, outerWorldCoordinates:Coordinate, mode:MODE, includeSelf : Bool ):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = super.findHitList(component, outerWorldCoordinates, mode, mode==MODE.INCLUDE_PARENTS) ;

        if( isInComponent(component, outerWorldCoordinates) && 
            component.get_boxType() == Box.WHITE_BOX )
        {
            var transform:Transform = makeTransform(component);
            var innerWorldCoordinates:Coordinate = transform.pointInvert(outerWorldCoordinates);
            var result:Array<HitObject> = circuitDiagram.findHitList(innerWorldCoordinates, mode);
            for( hitOject in result ) {
                hitObjectArray.push( hitOject ) ;
            }
        }
        return hitObjectArray ;
    }

    override public function findWorldPoint(component : Component,
                                            worldCoordinate:Coordinate,
                                            mode:POINT_MODE)
        : Array<WorldPoint>
    {
        var worldPointArray:Array<WorldPoint> = new Array<WorldPoint>() ;

        if(isInComponent(component, worldCoordinate) == null){
            return worldPointArray;
        }else if(component.get_boxType() == Box.WHITE_BOX){
            var transform:Transform = makeTransform(component);
            var wForDiagram:Coordinate = transform.pointInvert(worldCoordinate);
            return circuitDiagram.findWorldPoint(wForDiagram, mode);
        }else{
            return worldPointArray;
        }

    }
}
