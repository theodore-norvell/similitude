package com.mun.model.gates;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.view.drawComponents.DrawCompoundComponent;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.enumeration.Box;
import com.mun.model.enumeration.MODE;
import com.mun.type.Type.Coordinate;
import com.mun.type.Type.WorldPoint;
import com.mun.view.drawingImpl.Transform;
import com.mun.model.component.Outport;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.component.Inport;
import com.mun.model.component.CircuitDiagram;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.model.enumeration.Orientation;
import com.mun.model.component.Port;
import com.mun.global.Constant.*;
/**
* compound Component
**/
class CompoundComponent implements ComponentKind extends GateAbstract{
    var circuitDiagram:CircuitDiagram;
    var outputCounter:Int;

    public function new(circuitDiagram:CircuitDiagram) {
        this.circuitDiagram = circuitDiagram;

        var inputCounter:Int = 0;
        outputCounter = 0;
        for(i in this.circuitDiagram.get_componentIterator()){
            if(i.getNameOfTheComponentKind() == "Input"){//find the input component
                inputCounter++;
            }else if(i.getNameOfTheComponentKind() == "Output"){
                outputCounter++;
            }
        }

        super(inputCounter);
    }

    override public function getInnerCircuitDiagram():CircuitDiagramI{
        return circuitDiagram;
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {
        return ; //TODO
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        //find how many inputs gate in the sub-circuit diagram
        switch(orientation){
            case Orientation.EAST : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2, height / (leastInportNum+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        inport_1.set_portDescription(IOTYPE.INPUT);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);

                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition + width / 2,  height / (outputCounter+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        outport_.set_portDescription(IOTYPE.OUTPUT);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);

                    }
                }
            };
            case Orientation.NORTH : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2 + width/ (leastInportNum+1) * (i.get_componentKind().get_sequence()+1), height + height/2);
                        inport_1.set_portDescription(IOTYPE.INPUT);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2 + width/ (outputCounter+1) * (i.get_componentKind().get_sequence()+1), height - height/2);
                        outport_.set_portDescription(IOTYPE.OUTPUT);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case Orientation.SOUTH : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2 + width/ (leastInportNum+1) * (i.get_componentKind().get_sequence()+1), height - height/2);
                        inport_1.set_portDescription(IOTYPE.INPUT);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2 + width/ (outputCounter+1) * (i.get_componentKind().get_sequence()+1), height + height/2);
                        outport_.set_portDescription(IOTYPE.OUTPUT);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case orientation.WEST : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition + width / 2, height / (leastInportNum+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        inport_1.set_portDescription(IOTYPE.INPUT);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2,  height / (outputCounter+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        outport_.set_portDescription(IOTYPE.OUTPUT);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    override public function addInPort():Port {//compound component can not add any inports or outports
        return null;
    }

    public function drawComponent(drawingAdapter:DrawingAdapterI, hightLight:Bool):Void {
        var drawComponent:DrawComponent = new DrawCompoundComponent(component, drawingAdapter);
        if(hightLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }

        if(BOX_TYPE == Box.WHITE_BOX){
            //compound component need to draw all the components in ComponentArray, which should make a new transfrom
            drawingAdapter = drawingAdapter.transform(makeTransform());
            circuitDiagram.draw(drawingAdapter);
        }
    }

    function makeTransform():Transform{
        var transform:Transform = Transform.identity();
        transform = transform.translate(component.get_xPosition(), component.get_yPosition()) *
                    transform.scale(component.get_width()/circuitDiagram.get_diagramWidth(), component.get_height()/circuitDiagram.get_diagramHeight()) *
                    transform.translate(-circuitDiagram.get_xMin(), -circuitDiagram.get_yMin());
        return transform;
    }

    override public function findHitList(coordinate:Coordinate, mode:MODE):LinkAndComponentAndEndpointAndPortArray{
        var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray = {"linkArray": null, "componentArray": null, "endpointArray": null, "portArray": null};

        var hitComponent:Component = isInComponent(coordinate);
        if(hitComponent == null){
            return linkAndComponentAndEndpointAndPortArray;
        }else if(BOX_TYPE == Box.WHITE_BOX){
            var transform:Transform = makeTransform();
            var worldCoordinate:Coordinate = transform.pointInvert(coordinate);
            var result:LinkAndComponentAndEndpointAndPortArray = circuitDiagram.findHitList(coordinate, mode);

            if((result.endpointArray == null && result.portArray == null && result.componentArray == null && result.linkArray) || mode == MODE.INCLUDE_PARENTS){
                return linkAndComponentAndEndpointAndPortArray.componentArray.push(component);
            }else{
                return result;
            }
        }else{
            return linkAndComponentAndEndpointAndPortArray.componentArray.push(component);
        }
    }

    override public function findWorldPoint(coordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        var worldPointAray:Array<WorldPoint> = new Array<WorldPoint>();

        if(isInComponent(coordinate) == null){
            return worldPointAray;
        }else if(BOX_TYPE == Box.WHITE_BOX){
            var transform:Transform = makeTransform();
            var wForDiagram:Coordinate = transform.pointInvert(coordinate);
            return circuitDiagram.findWorldPoint(coordinate, mode);
        }else{
            return worldPointAray;
        }

    }
}
