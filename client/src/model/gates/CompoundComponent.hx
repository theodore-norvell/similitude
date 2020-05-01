package model.gates;

import model.selectionModel.SelectionModel;
import assertions.Assert ;
import model.observe.Observable;
import model.observe.Observer;
import type.HitObject;
import type.WorldPoint;
import model.drawComponents.DrawComponent;
import model.drawComponents.DrawCompoundComponent;
import model.component.CircuitDiagramI;
import model.component.Component ;
import model.enumeration.POINT_MODE;
import model.enumeration.BOX;
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
    var nameOfTheComponentKind:String="CC";

    public function new(circuitDiagram:CircuitDiagramI) {
        super() ;
        this.circuitDiagram = circuitDiagram;
    }


    public function getname():String{
        return nameOfTheComponentKind;
    }

    override public function getInnerCircuitDiagram():CircuitDiagramI{
        return circuitDiagram;
    }

    // public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, ?inportNum:Int):Array<Port> {
    //     var inportCount = 0 ;
    //     var outportCount = 0 ;
    //     for(i in circuitDiagram.get_componentIterator()){
    //         if(i.getNameOfTheComponentKind() == "Input"){
    //             inportCount += 1 ;
    //         }else if(i.getNameOfTheComponentKind() == "Output"){
    //             outportCount += 1 ;
    //         }
    //     }
    //     var portArray:Array<Port> = new Array<Port>();
    //     //find how many inputs gate in the sub-circuit diagram
    //     switch(orientation){
    //         case Orientation.EAST : {
    //             for(i in circuitDiagram.get_componentIterator()){
    //                 if(i.getNameOfTheComponentKind() == "Input"){
    //                     //inport
    //                     var inport_1:Port = new Port(xPosition - width / 2,
    //                                                    height / (inportCount+1) * (i.get_sequence()+1)
    //                                                    + (yPosition - height / 2));
    //                     inport_1.set_sequence(i.get_sequence());
    //                     portArray.push(inport_1);
    //                 }else if(i.getNameOfTheComponentKind() == "Output"){
    //                     //outport
    //                     var outport_:Port = new Port(xPosition + width / 2,
    //                                                     height / (outportCount+1) * (i.get_sequence()+1)
    //                                                     + (yPosition - height / 2));
    //                     outport_.set_sequence(i.get_sequence());
    //                     portArray.push(outport_);
    //                 }
    //             }
    //         };
    //         case Orientation.NORTH : {
    //             for(i in circuitDiagram.get_componentIterator()){
    //                 if(i.getNameOfTheComponentKind() == "Input"){
    //                     //inport
    //                     var inport_1:Port = new Port(xPosition - width / 2 + width/ (inportCount+1) * (i.get_sequence()+1),
    //                                                    height + height/2);
    //                     inport_1.set_sequence(i.get_sequence());
    //                     portArray.push(inport_1);
    //                 }else if(i.getNameOfTheComponentKind() == "Output"){
    //                     //outport
    //                     var outport_:Port = new Port(xPosition - width / 2 + width/ (outportCount+1) * (i.get_sequence()+1),
    //                                                     height - height/2);
    //                     outport_.set_sequence(i.get_sequence());
    //                     portArray.push(outport_);
    //                 }
    //             }
    //         };
    //         case Orientation.SOUTH : {
    //             for(i in circuitDiagram.get_componentIterator()){
    //                 if(i.getNameOfTheComponentKind() == "Input"){
    //                     //inport
    //                     var inport_1:Port = new Port(xPosition - width / 2 + width/ (inportCount+1) * (i.get_sequence()+1),
    //                                                    height - height/2);
    //                     inport_1.set_sequence(i.get_sequence());
    //                     portArray.push(inport_1);
    //                 }else if(i.getNameOfTheComponentKind() == "Output"){
    //                     //outport
    //                     var outport_:Port = new Port( xPosition - width / 2 + width/ (outportCount+1) * (i.get_sequence()+1),
    //                                                      height + height/2);
    //                     outport_.set_sequence(i.get_sequence());
    //                     portArray.push(outport_);
    //                 }
    //             }
    //         };
    //         case Orientation.WEST : {
    //             for(i in circuitDiagram.get_componentIterator()){
    //                 if(i.getNameOfTheComponentKind() == "Input"){
    //                     //inport
    //                     var inport_1:Port = new Port( xPosition + width / 2,
    //                                                     height / (inportCount+1) * (i.get_sequence()+1) + (yPosition - height / 2));
    //                     inport_1.set_sequence(i.get_sequence());
    //                     portArray.push(inport_1);
    //                 }else if(i.getNameOfTheComponentKind() == "Output"){
    //                     //outport
    //                     var outport_:Port = new Port( xPosition - width / 2,
    //                                                      height / (outportCount+1) * (i.get_sequence()+1) + (yPosition - height / 2));
    //                     outport_.set_sequence(i.get_sequence());
    //                     portArray.push(outport_);
    //                 }
    //             }
    //         };
    //         default : {
    //             Assert.assert( false ) ;
    //         }
    //     }
    //     return portArray;
    // }

    public function drawComponent(component : Component, drawingAdapter:DrawingAdapterI, highlight:Bool,  selection : SelectionModel ):Void {
        var drawingAdapterTrans:DrawingAdapterI = drawingAdapter.transform(makeTransform(component));
        var drawComponent:DrawCompoundComponent = new DrawCompoundComponent(component, drawingAdapter, highlight, drawingAdapterTrans);
        drawComponent.drawCorrespondingComponent() ;

        if(component.get_boxType() == BOX.WHITE_BOX){
            // Draw the inside of the circuit.
            circuitDiagram.draw(drawingAdapterTrans, selection);
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

    override public function findHitList(component : Component, outerWorldCoordinates:Coordinate, mode:MODE):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();

        var hitComponent:Component = isInComponent(component, outerWorldCoordinates);
        if(hitComponent == null){
            return hitObjectArray;
        }else if(component.get_boxType() == BOX.WHITE_BOX){
            var transform:Transform = makeTransform(component);
            var innerWorldCoordinates:Coordinate = transform.pointInvert(outerWorldCoordinates);
            var result:Array<HitObject> = circuitDiagram.findHitList(innerWorldCoordinates, mode);

            if(result.length == 0 || mode == MODE.INCLUDE_PARENTS){
                var hitObject:HitObject = new HitObject();
                hitObject.set_component(component);
                result.push(hitObject);
            }
            return result;
        }else{
            var hitObject:HitObject = new HitObject();
            hitObject.set_component(component);
            hitObjectArray.push(hitObject);
            return hitObjectArray;
        }
    }

    override public function findWorldPoint(component : Component,
                                            worldCoordinate:Coordinate,
                                            mode:POINT_MODE)
        : Array<WorldPoint>
    {
        var worldPointArray:Array<WorldPoint> = new Array<WorldPoint>() ;

        if(isInComponent(component, worldCoordinate) == null){
            return worldPointArray;
        }else if(component.get_boxType() == BOX.WHITE_BOX){
            var transform:Transform = makeTransform(component);
            var wForDiagram:Coordinate = transform.pointInvert(worldCoordinate);
            return circuitDiagram.findWorldPoint(wForDiagram, mode);
        }else{
            return worldPointArray;
        }

    }
}
