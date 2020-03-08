package model.gates;

import assertions.Assert ;
import model.attribute.OrientationAttr;
import model.attribute.StringAttr;
import model.attribute.IntAttr;
import model.attribute.Attribute;
import type.LinkAndComponentAndEndpointAndPortArray;
import view.drawComponents.DrawComponent;
import model.drawingInterface.DrawingAdapterI;
import view.drawComponents.DrawFlipFlop;
import model.component.Inport;
import model.component.Outport;
import model.component.Port;
import model.enumeration.IOTYPE;
import model.enumeration.ORIENTATION;
/**
 * Flip-Flop<br>
 * Truth Table
 * <br>
 * <pre>
 * ****************************************
 * *|   CLK  |    D   |    Q   |    QN   |*<br>
 * *|    0   |    0   |    Q   |    QN   |*<br>
 * *|    0   |    1   |    Q   |    QN   |*<br>
 * *|    1   |    0   |    0   |    1    |*<br>
 * *|    1   |    1   |    1   |    0    |*<br>
 * ****************************************
 *  </pre>
 * @author wanhui
 *
 */
class FlipFlop implements ComponentKind extends AbstractComponentKind {

    var nameOfTheComponentKind:String="FlipFlop";

    public function new() {
        super();
        attributes.push(new IntAttr("delay"));
        attributes.push(new IntAttr("hold"));
        attributes.push(new IntAttr("setup"));
    }

    public function setname(s:String):Void{
        nameOfTheComponentKind=s;
    }

    public function getname():String {
        return nameOfTheComponentKind;
    }

    public function createPorts(xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION, ?inportNum:Int):Array<Port> {
        var portArray:Array<Port> = new Array<Port>();
        //flip-flop have an input inport and one clock inport
        switch (orientation){
            case ORIENTATION.EAST : {
                //inport
                var inport_D:Port = new Inport(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            case ORIENTATION.WEST : {
                //inport
                var inport_D:Port = new Inport(xPosition + width / 2, height / 3 * 1 + (yPosition - height / 2));
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition + width / 2, height / 3 * 2 + (yPosition - height / 2));
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition - width / 2, height / 3 * 1 + (yPosition - height / 2));
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition - width / 2, height / 3 * 2 + (yPosition - height / 2));
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            case ORIENTATION.SOUTH : {
                //inport
                var inport_D:Port = new Inport(xPosition - width / 2 + width / 3 * 1, yPosition - height / 2);
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition - width / 2 + width / 3 * 2, yPosition - height / 2);
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition - width / 2 + width / 3 * 1, yPosition + height / 2);
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition - width / 2 + width / 3 * 2, yPosition + height / 2);
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            case ORIENTATION.NORTH : {
                //inport
                var inport_D:Port = new Inport(xPosition - width / 2 + width / 3 * 1, yPosition + height / 2);
                inport_D.set_portDescription(IOTYPE.D);
                portArray.push(inport_D);
                var inport_CLK:Port = new Inport(xPosition - width / 2 + width / 3 * 2, yPosition + height / 2);
                inport_CLK.set_portDescription(IOTYPE.CLK);
                portArray.push(inport_CLK);
                //outport
                var outport_Q:Port = new Outport(xPosition - width / 2 + width / 3 * 1, yPosition - height / 2);
                outport_Q.set_portDescription(IOTYPE.Q);
                portArray.push(outport_Q);
                var outport_QN:Port = new Outport(xPosition - width / 2 + width / 3 * 2, yPosition - height / 2);
                outport_QN.set_portDescription(IOTYPE.QN);
                portArray.push(outport_QN);
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    override public function addInPort():Port {
        Assert.assert(false) ;
        return null;//because flip-flop can't add any ports
    }

    /**
    * different from others, this function used in move command when the componenet has been re-located
    **/
    override public function updateInPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port> {
        switch (orientation){
            case ORIENTATION.EAST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.WEST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.D){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.CLK){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }
                }
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }
    /**
    * different from others, this function used in move command when the componenet has been re-located
    **/
    override public function updateOutPortPosition(portArray:Array<Port>, xPosition:Float, yPosition:Float, height:Float, width:Float, orientation:ORIENTATION):Array<Port>{
        switch (orientation){
            case ORIENTATION.EAST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition + width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.WEST : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 1 + (yPosition - height / 2));
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition - width / 2);
                        portArray[i].set_yPosition(height / 3 * 2 + (yPosition - height / 2));
                    }
                }
            };
            case ORIENTATION.SOUTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition + height / 2);
                    }
                }
            };
            case ORIENTATION.NORTH : {
                for(i in 0...portArray.length){
                    if(portArray[i].get_portDescription() == IOTYPE.Q){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 1);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }

                    if(portArray[i].get_portDescription() == IOTYPE.QN){
                        portArray[i].set_xPosition(xPosition - width / 2 + width / 3 * 2);
                        portArray[i].set_yPosition(yPosition - height / 2);
                    }
                }
            };
            default : {
                //do nothing
            }
        }
        return portArray;
    }

    public function drawComponent(drawingAdapter:DrawingAdapterI, highLight:Bool, ?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        var drawComponent:DrawComponent = new DrawFlipFlop(component, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
    }
}
