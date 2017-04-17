package com.mun.controller.componentUpdate;

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

    public function new(circuitDiagram:CircuitDiagram,updateCanvas:UpdateCanvas) {
        this.circuitDiagram = circuitDiagram;
        this.updateCanvas = updateCanvas;

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
    }
    public function moveComponent(coordinate:Coordinate){
        var object:Object = circuitDiagramUtil.isInComponent(coordinate);
        if(object.component != null){
            var command:Command = new MoveCommand(object,coordinate.xPosition, coordinate.yPosition, object.component.get_xPosition(),object.component.get_yPosition(), circuitDiagram);
            commandManager.execute(command);
            redrawCanvas();
        }else {
            if(object.endPoint != null){

            }else if(object.link != null){

            }
        }

    }

    public function addLink(coordinateFrom:Coordinate, coordinateTo:Coordinate){
        var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
        object = portAction(coordinateFrom);
        if(object.port != null){
            var leftEndpoint:Endpoint = new Endpoint(object.port.get_xPosition(), object.port.get_yPosition());
            var rightEndpoint:Endpoint = new Endpoint(object.port.get_xPosition(), object.port.get_yPosition());
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            object.link = link;
            object.endPoint = null;
        }else{
            var leftEndpoint:Endpoint = new Endpoint(coordinateFrom.xPosition, coordinateFrom.yPosition);
            var rightEndpoint:Endpoint = new Endpoint(coordinateTo.xPosition+100, coordinateTo.yPosition+100);
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            object.link = link;
        }
        var command:Command = new AddCommand(object,circuitDiagram);
        redrawCanvas();
    }

    public function moveEndpoint(coordinate:Coordinate){
        var object:Object = circuitDiagramUtil.isOnPort(coordinate);
        if(object.endPoint != null){
            var command:Command = new MoveCommand(object,coordinate.xPosition, coordinate.yPosition, object.endPoint.get_xPosition(),object.endPoint.get_yPosition(), circuitDiagram);
            commandManager.execute(command);
            redrawCanvas();
        }
    }

    public function portAction(coordinate:Coordinate):Object{
        return circuitDiagramUtil.isOnPort(coordinate);
    }

    function redrawCanvas(){
        updateCanvas.update();
    }
}
