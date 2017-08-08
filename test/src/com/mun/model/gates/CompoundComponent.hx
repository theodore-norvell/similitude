package com.mun.model.gates;
import com.mun.type.HitObject;
import com.mun.type.WorldPoint;
import com.mun.view.drawComponents.DrawComponent;
import com.mun.view.drawComponents.DrawCompoundComponent;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.enumeration.BOX;
import com.mun.model.enumeration.MODE;
import com.mun.type.Coordinate;
import com.mun.view.drawingImpl.Transform;
import com.mun.model.component.Outport;
import com.mun.model.enumeration.IOTYPE;
import com.mun.model.component.Inport;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.component.Port;
/**
* compound Component
**/
class CompoundComponent implements ComponentKind extends GateAbstract{
    var circuitDiagram:CircuitDiagramI;
    var outputCounter:Int;

    public function new(circuitDiagram:CircuitDiagramI) {
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
        return null; //TODO
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
        var portArray:Array<Port> = new Array<Port>();
        //find how many inputs gate in the sub-circuit diagram
        switch(orientation){
            case ORIENTATION.EAST : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2, height / (leastInportNum+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition + width / 2,  height / (outputCounter+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2 + width/ (leastInportNum+1) * (i.get_componentKind().get_sequence()+1), height + height/2);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2 + width/ (outputCounter+1) * (i.get_componentKind().get_sequence()+1), height - height/2);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition - width / 2 + width/ (leastInportNum+1) * (i.get_componentKind().get_sequence()+1), height - height/2);
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2 + width/ (outputCounter+1) * (i.get_componentKind().get_sequence()+1), height + height/2);
                        outport_.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(outport_);
                    }
                }
            };
            case ORIENTATION.WEST : {
                for(i in circuitDiagram.get_componentIterator()){
                    if(i.getNameOfTheComponentKind() == "Input"){
                        //inport
                        var inport_1:Port = new Inport(xPosition + width / 2, height / (leastInportNum+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
                        inport_1.set_sequence(i.get_componentKind().get_sequence());
                        portArray.push(inport_1);
                    }else if(i.getNameOfTheComponentKind() == "Output"){
                        //outport
                        var outport_:Port = new Outport(xPosition - width / 2,  height / (outputCounter+1) * (i.get_componentKind().get_sequence()+1) + (yPosition - height / 2));
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

    public function drawComponent(drawingAdapter:DrawingAdapterI, hightLight:Bool):Void {
        var drawComponent:DrawComponent = new DrawCompoundComponent(component, drawingAdapter);
        if(hightLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }

        if(component.get_boxType() == BOX.WHITE_BOX){
            //compound component need to draw all the components in ComponentArray, which should make a new transfrom
            drawingAdapter = drawingAdapter.transform(makeTransform());
            circuitDiagram.draw(drawingAdapter);
        }
    }

    function makeTransform():Transform{
        var transform:Transform = Transform.identity();
        transform = transform.translate(-circuitDiagram.getCircuitDiagramCenterPoint().get_xPosition(), -circuitDiagram.getCircuitDiagramCenterPoint().get_yPosition())
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
            for(i in result){
                i.set_circuitDiagram(circuitDiagram);
            }

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

    override public function createJSon():String{
        var jsonString:String = "{ \"leastInportNum\": \"" + this.leastInportNum + "\",";
        jsonString += "\"sequence\": \"" + this.sequence + "\",";
        jsonString += "\"CircuitDiagram\": " + circuitDiagram.createJSon();
        jsonString += "}";

        return jsonString;
    }
}
