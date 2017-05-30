package com.mun.model.gates;
import com.mun.model.component.Inport;
import com.mun.model.component.Port;
import com.mun.model.enumeration.Orientation;
/**
* abstract class for gates
* @author wanhui
**/
class GateAbstract {
    var leastInportNum:Int;

    private function new(leastInportNum:Int) {
        this.leastInportNum = leastInportNum;
    }

    public function getLeastInportNumber():Int {
        return this.leastInportNum;
    }

    public function addInPort():Port {
        return new Inport();
    }

    public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port> {
        switch (orientation){
            case Orientation.EAST : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2);
                    portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                    if (portArray[i].get_sequence() == -1) {
                        portArray[i].set_sequence(i);
                    }
                }
            };
            case Orientation.NORTH : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                    portArray[i].set_yPosition(yPosition + height / 2);
                    if (portArray[i].get_sequence() == -1) {
                        portArray[i].set_sequence(i);
                    }
                }
            };
            case Orientation.SOUTH : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition - width / 2 + width / (portArray.length + 1) * (i + 1));
                    portArray[i].set_yPosition(yPosition - height / 2);
                    if (portArray[i].get_sequence() == -1) {
                        portArray[i].set_sequence(i);
                    }
                }
            };
            case Orientation.WEST : {
                for (i in 0...portArray.length) {
                    portArray[i].set_xPosition(xPosition + width / 2);
                    portArray[i].set_yPosition(height / (portArray.length + 1) * (i + 1) + (yPosition - height / 2));
                    if (portArray[i].get_sequence() == -1) {
                        portArray[i].set_sequence(i);
                    }
                }
            };
            default:{
                //do nothing
            }
        }
        return portArray;
    }

    public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:Orientation):Array<Port>{
        switch(orientation){
            case Orientation.EAST : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition + width / 2);
                    portArray[i].set_yPosition(yPosition);
                }
            };
            case Orientation.NORTH : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition);
                    portArray[i].set_yPosition(yPosition - height / 2);
                }
            };
            case Orientation.SOUTH : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition);
                    portArray[i].set_yPosition(yPosition + height / 2);
                }
            };
            case Orientation.WEST : {
                for(i in 0...portArray.length){
                    portArray[i].set_xPosition(xPosition - width / 2);
                    portArray[i].set_yPosition(yPosition);
                }
            };
            default:{
                //do nothing
            }
        }
        return portArray;
    }
}
