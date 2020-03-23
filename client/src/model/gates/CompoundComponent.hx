package model.gates;

import model.selectionModel.SelectionModel;
import assertions.Assert ;
import model.observe.Observable;
import model.attribute.OrientationAttr;
import model.attribute.StringAttr;
import model.attribute.IntAttr;
import model.attribute.Attribute;
import model.observe.Observer;
import type.LinkAndComponentAndEndpointAndPortArray;
import type.HitObject;
import type.WorldPoint;
import view.drawComponents.DrawComponent;
import view.drawComponents.DrawCompoundComponent;
import model.component.CircuitDiagramI;
import model.enumeration.POINT_MODE;
import model.enumeration.BOX;
import model.enumeration.MODE;
import type.Coordinate;
import model.drawingInterface.Transform;
import model.component.Outport;
import model.component.Inport;
import model.drawingInterface.DrawingAdapterI;
import model.component.Component;
import model.enumeration.ORIENTATION;
import model.component.Port;
/**
* compound Component
**/
class CompoundComponent implements ComponentKind extends AbstractComponentKind{
    var Ob:Observer;
    var Obable:Observable;
    var circuitDiagram:CircuitDiagramI;
    var nameOfTheComponentKind:String="CC";

    public function setname(s:String):Void{
        nameOfTheComponentKind=s;
    }

    public function getname():String{
        return nameOfTheComponentKind;
    }


    public function new(circuitDiagram:CircuitDiagramI) {
        super() ;
        this.circuitDiagram = circuitDiagram;
    }

    override public function getInnerCircuitDiagram():CircuitDiagramI{
        return circuitDiagram;
    }

    override public function checkInnerCircuitDiagramPortsChange():Bool{
        var inputNumberTemp:Int = 0;
        var outputNumberTemp:Int = 0;

        for(i in circuitDiagram.get_componentIterator()){
            if(i.getNameOfTheComponentKind() == "Input"){
                inputNumberTemp++;
            }
            if(i.getNameOfTheComponentKind() == "Output"){
                outputNumberTemp++;
            }
        }

        if(inputNumberTemp == component.get_inportIteratorLength() && outputNumberTemp == component.get_outportIteratorLength()){
            return false;
        }else{
            return true;
        }
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {
        var inportCount = 0 ;
        var outportCount = 0 ;
        for(i in circuitDiagram.get_componentIterator()){
            if(i.getNameOfTheComponentKind() == "Input"){
                inportCount += 1 ;
            }else if(i.getNameOfTheComponentKind() == "Output"){
                outportCount += 1 ;
            }
        }
        var portArray:Array<Port> = new Array<Port>();
        //find how many inputs gate in the sub-circuit diagram
        switch(orientation){
            case ORIENTATION.EAST : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2,
                                                       height / (inportCount+1) * (i.get_componentKind().get_sequence()+1)
                                                       + (yPosition - height / 2));
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition + width / 2,
                                                        height / (outportCount+1) * (i.get_componentKind().get_sequence()+1)
                                                        + (yPosition - height / 2));
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2 + width/ (inportCount+1) * (i.get_componentKind().get_sequence()+1), height + height/2);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2 + width/ (outportCount+1) * (i.get_componentKind().get_sequence()+1), height - height/2);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2 + width/ (inportCount+1) * (i.get_componentKind().get_sequence()+1), height - height/2);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2 + width/ (outportCount+1) * (i.get_componentKind().get_sequence()+1), height + height/2);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case ORIENTATION.WEST : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition + width / 2, height / (inportCount+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2,  height / (outportCount+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            default : {
                Assert.assert( false ) ;
            }
        }
        return portArray;
    }

    public function drawComponent(drawingAdapter:DrawingAdapterI, hightLight:Bool,  selection : SelectionModel ):Void {
        var drawingAdapterTrans:DrawingAdapterI = drawingAdapter.transform(makeTransform());
        var drawComponent:DrawComponent = new DrawCompoundComponent(component, drawingAdapter, drawingAdapterTrans);
        if(hightLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }

        if(component.get_boxType() == BOX.WHITE_BOX){
            //compound component need to draw all the components in ComponentArray, which should make a IntAttr transfrom
            drawingAdapterTrans = drawingAdapter.transform(makeTransform());
            circuitDiagram.draw(drawingAdapterTrans, selection);
        }
    }

    function makeTransform():Transform{
        var transform:Transform = Transform.identity();
        transform = transform.translate(-circuitDiagram.getComponentAndLinkCenterCoordinate().get_xPosition(), -circuitDiagram.getComponentAndLinkCenterCoordinate().get_yPosition())
                    .scale(component.get_width()/circuitDiagram.get_diagramWidth(), component.get_height()/circuitDiagram.get_diagramHeight())
                    .translate(component.get_xPosition(), component.get_yPosition());

        return transform;
    }

    override public function findHitList(outerWorldCoordinates:Coordinate, mode:MODE):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();

        var hitComponent:Component = isInComponent(outerWorldCoordinates);
        if(hitComponent == null){
            return hitObjectArray;
        }else if(component.get_boxType() == BOX.WHITE_BOX){
            var transform:Transform = makeTransform();
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

    override public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        var worldPointArray:Array<WorldPoint> = new Array<WorldPoint>();

        if(isInComponent(worldCoordinate) == null){
            return worldPointArray;
        }else if(component.get_boxType() == BOX.WHITE_BOX){
            var transform:Transform = makeTransform();
            var wForDiagram:Coordinate = transform.pointInvert(worldCoordinate);
            return circuitDiagram.findWorldPoint(wForDiagram, mode);
        }else{
            return worldPointArray;
        }

    }
}
