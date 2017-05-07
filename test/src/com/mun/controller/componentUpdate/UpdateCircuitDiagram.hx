package com.mun.controller.componentUpdate;

import com.mun.model.component.Port;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Link;
import com.mun.controller.command.MoveCommand;
import com.mun.type.Type.Object;
import com.mun.controller.command.Command;
import com.mun.controller.command.AddCommand;
import com.mun.controller.command.CommandManager;
import com.mun.model.gates.ComponentKind;
import com.mun.model.enumeration.Orientation;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.CircuitDiagram;
import com.mun.model.component.Component;
import com.mun.type.Type.Coordinate;

//all of those imports below can not be deleted, because of using Type.resolveClass
import com.mun.model.gates.AND;
import com.mun.model.gates.FlipFlop;
import com.mun.model.gates.Input;
import com.mun.model.gates.MUX;
import com.mun.model.gates.NAND;
import com.mun.model.gates.NOR;
import com.mun.model.gates.NOT;
import com.mun.model.gates.OR;
import com.mun.model.gates.Output;
import com.mun.model.gates.XOR;
//the above imports shouldn't be deleted

class UpdateCircuitDiagram {
    var circuitDiagram:CircuitDiagram;
    var updateCanvas:UpdateCanvas;
    var commandManager:CommandManager;
    var circuitDiagramUtil:CircuitDiagramUtil;
    var updateToolBar:UpdateToolBar;

    public function new(circuitDiagram:CircuitDiagram,updateCanvas:UpdateCanvas, updateToolBar:UpdateToolBar) {
        this.circuitDiagram = circuitDiagram;
        this.updateCanvas = updateCanvas;
        this.updateToolBar = updateToolBar;

        commandManager = new CommandManager(circuitDiagram);
        circuitDiagramUtil = new CircuitDiagramUtil(circuitDiagram);
    }

    public function createComponentByButton(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:Orientation, inportNum:Int, drawingAdapter:DrawingAdapterI){
        var componentkind_:ComponentKind = Type.createInstance(Type.resolveClass("com.mun.model.gates." + name),[]);
        var component_:Component = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        component_.setNameOfTheComponentKind(name);

        var object:Object = {"link":null,"component":component_,"endPoint":null, "port":null};
        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);
        redrawCanvas();
        updateToolBar.update(object.component);
        hightLightObject(object);
    }
    public function moveComponent(object:Object, coordinate:Coordinate){
        if(object.component != null){
            var command:Command = new MoveCommand(object,coordinate.xPosition, coordinate.yPosition, object.component.get_xPosition(),object.component.get_yPosition(), circuitDiagram);
            commandManager.execute(command);
            //those wires which link to this component should move either

            redrawCanvas(object);
        }else {
            if(object.endPoint != null){

            }else if(object.link != null){

            }
        }

    }

    public function addLink(coordinateFrom:Coordinate, coordinateTo:Coordinate):Link{
        var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
        object = portAction(coordinateFrom);
        if(object.port != null){
            var leftEndpoint:Endpoint = new Endpoint(object.port.get_xPosition(), object.port.get_yPosition());
            var rightEndpoint:Endpoint = new Endpoint(object.port.get_xPosition(), object.port.get_yPosition());
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            link.get_leftEndpoint().set_port(object.port);
            object.link = link;
            object.endPoint = null;
        }else{
            var leftEndpoint:Endpoint = new Endpoint(coordinateFrom.xPosition, coordinateFrom.yPosition);
            var rightEndpoint:Endpoint = new Endpoint(coordinateTo.xPosition+100, coordinateTo.yPosition+100);
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            object.link = link;
        }
        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);
        redrawCanvas(object);
        return object.link;
    }

    public function moveEndpoint(coordinate:Coordinate, endpoint:Endpoint){
        var object:Object = {"link":null,"component":null,"endPoint":endpoint, "port":null};
        if(object.endPoint != null){

            var command:Command = new MoveCommand(object,coordinate.xPosition, coordinate.yPosition, object.endPoint.get_xPosition(),object.endPoint.get_yPosition(), circuitDiagram);
            commandManager.execute(command);
            redrawCanvas();

            var componentArray:Array<Component> = circuitDiagram.get_componentArray();
            for(i in 0...componentArray.length){
                var inportArray:Array<Port> = componentArray[i].get_inportArray();
                for(j in 0...inportArray.length){
                    if(circuitDiagramUtil.isInCircle(coordinate, inportArray[j].get_xPosition(), inportArray[j].get_yPosition())){
                        object.endPoint.set_port(inportArray[j]);
                        var command:Command = new MoveCommand(object,inportArray[j].get_xPosition(), inportArray[j].get_yPosition(), object.endPoint.get_xPosition(),object.endPoint.get_yPosition(), circuitDiagram);
                        commandManager.execute(command);
                        redrawCanvas();
                    }
                }

                var outportArray:Array<Port> = componentArray[i].get_outportArray();
                for(j in 0...outportArray.length){
                    if(circuitDiagramUtil.isInCircle(coordinate, outportArray[j].get_xPosition(), outportArray[j].get_yPosition())){
                        object.endPoint.set_port(outportArray[j]);
                        var command:Command = new MoveCommand(object,outportArray[j].get_xPosition(), outportArray[j].get_yPosition(), object.endPoint.get_xPosition(),object.endPoint.get_yPosition(), circuitDiagram);
                        commandManager.execute(command);
                        redrawCanvas();
                    }
                }
            }

        }
    }

    public function getComponent(coordinate:Coordinate):Object{
        return circuitDiagramUtil.isInComponent(coordinate);
    }

    public function hightLightObject(object:Object){
        redrawCanvas(object);
    }

    public function portAction(coordinate:Coordinate):Object{
        return circuitDiagramUtil.isOnPort(coordinate);
    }

    function redrawCanvas(?object:Object){
        updateCanvas.update(object);
    }
}
