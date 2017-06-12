package com.mun.model.gates;
import com.mun.model.component.CircuitDiagram;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.Component;
import com.mun.model.enumeration.Orientation;
import com.mun.model.component.Port;
/**
* compound Component
**/
class CompoundComponent implements ComponentKind{
    var leastInportNumber:Int = 1;
    var circuitDiagram:CircuitDiagram;

    public function new(circuitDiagram:CircuitDiagram) {
        this.circuitDiagram = circuitDiagram;

        var inputCounter:Int = 0;
        for(i in this.circuitDiagram.get_componentIterator()){
            if(i.getNameOfTheComponentKind() == "Input"){//find the input component
                inputCounter++;
            }
        }

        leastInportNumber = inputCounter;
    }

    public function getLeastInportNumber():Int {
        return this.leastInportNumber;
    }

    public function algorithm(portArray:Array<Port>):Array<Port> {

    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation, inportNum:Int):Array<Port> {
        return null;
    }

    public function addInPort():Port {//this function is useless because this is compoundComponent
        return null;
    }

    public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        return null;
    }

    public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        return null;
    }

    public function drawComponent(component:Component, drawingAdapter:DrawingAdapterI, hightLight:Bool):Void {

    }
}
