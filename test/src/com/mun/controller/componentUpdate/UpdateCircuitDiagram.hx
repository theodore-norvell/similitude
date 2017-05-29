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
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.type.Type.Coordinate;

//all of those imports below can not be deleted, because of using Type.resolveClass
//include all of the class under com.mun.model.gates
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
/**
* update the  circuit diagram. All the changes from the canvas will be send to here, and
* update the circuit diagram by using other functions
**/
class UpdateCircuitDiagram {
    var circuitDiagram:CircuitDiagramI;
    var updateCanvas:UpdateCanvas;
    var commandManager:CommandManager;
    var circuitDiagramUtil:CircuitDiagramUtil;
    var updateToolBar:UpdateToolBar;

    public function new(circuitDiagram:CircuitDiagramI) {
        this.circuitDiagram = circuitDiagram;

        commandManager = new CommandManager(circuitDiagram);
        circuitDiagramUtil = new CircuitDiagramUtil(circuitDiagram);
    }

    public function setUpdateCanvas(updateCanvas:UpdateCanvas){
        this.updateCanvas = updateCanvas;
    }

    public function setUpdateToolBar(updateToolBar:UpdateToolBar){
        this.updateToolBar = updateToolBar;
    }

    public function createComponentByButton(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:Orientation, inportNum:Int, drawingAdapter:DrawingAdapterI){
        var componentkind_:ComponentKind = Type.createInstance(Type.resolveClass("com.mun.model.gates." + name),[]);
        var component_:Component = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        component_.setNameOfTheComponentKind(name);

        var object:Object = {"link":null,"component":component_,"endPoint":null, "port":null};
        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);
        redrawCanvas(object);
        updateToolBar.update(object);
    }
    public function moveComponent(component:Component, coordinate:Coordinate, mouseDownLocation:Coordinate){
        var object:Object = {"link":null,"component":component,"endPoint":null, "port":null};

        var xMoveDistance:Float = coordinate.xPosition - mouseDownLocation.xPosition;
        var yMoveDistance:Float = coordinate.yPosition - mouseDownLocation.yPosition;

        var command:Command = new MoveCommand(object,object.component.get_xPosition() + xMoveDistance , object.component.get_yPosition() + yMoveDistance, object.component.get_xPosition(),object.component.get_yPosition(), circuitDiagram);
        commandManager.execute(command);
        //those wires which link to this component should move either, which automactilly completed while move endpoint
        redrawCanvas(object);
    }

    public function moveLink(link:Link, coordinate:Coordinate, mouseDownLocation:Coordinate){
        var object:Object = {"link":link,"component":null,"endPoint":null, "port":null};

        var xDisplacement:Float = mouseDownLocation.xPosition - coordinate.xPosition;
        var yDisplacement:Float = mouseDownLocation.yPosition - coordinate.yPosition;

        var command:Command = new MoveCommand(object,link.get_leftEndpoint().get_xPosition() - xDisplacement, link.get_leftEndpoint().get_yPosition() - yDisplacement, link.get_leftEndpoint().get_xPosition(), link.get_leftEndpoint().get_yPosition(), circuitDiagram);
        commandManager.execute(command);

        //verfy the endpoint of this link connect to a port or not while moving
        var index:Int = circuitDiagram.get_linkArray().indexOf(link);
        //left endpoint
        var leftEndpointCoordinate:Coordinate = {"xPosition":circuitDiagram.get_linkArray()[index].get_leftEndpoint().get_xPosition(),
            "yPosition":circuitDiagram.get_linkArray()[index].get_leftEndpoint().get_yPosition()};
        var port_temp:Port = isOnPort(leftEndpointCoordinate).port;
        var leftEndpointPort:Port = circuitDiagram.get_linkArray()[index].get_leftEndpoint().get_port();
        if(port_temp != null && leftEndpointPort != port_temp){//left endpoint met a port
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().set_port(port_temp);
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().updatePosition();
        }else if(port_temp == null){
            circuitDiagram.get_linkArray()[index].get_leftEndpoint().set_port(null);
        }

        var rightEndpointCoordinate:Coordinate = {"xPosition":circuitDiagram.get_linkArray()[index].get_rightEndpoint().get_xPosition(),
            "yPosition":circuitDiagram.get_linkArray()[index].get_rightEndpoint().get_yPosition()};
        port_temp = isOnPort(rightEndpointCoordinate).port;
        var rightEndpointPort:Port = circuitDiagram.get_linkArray()[index].get_rightEndpoint().get_port();

        if(port_temp != null && rightEndpointPort != port_temp){//left endpoint met a port
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().set_port(port_temp);
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().updatePosition();
        }else if(port_temp == null){
            circuitDiagram.get_linkArray()[index].get_rightEndpoint().set_port(null);
        }

        redrawCanvas();
        updateToolBar.update(object);
        hightLightObject(object);
    }

    public function addLink(coordinateFrom:Coordinate, coordinateTo:Coordinate):Link{
        var object:Object = {"link":null,"component":null,"endPoint":null, "port":null};
        object = isOnPort(coordinateFrom);
        if(object.port != null){
            var leftEndpoint:Endpoint = new Endpoint(object.port.get_xPosition(), object.port.get_yPosition());
            var rightEndpoint:Endpoint = new Endpoint(object.port.get_xPosition(), object.port.get_yPosition());
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            link.get_leftEndpoint().set_port(object.port);
            link.get_rightEndpoint().set_port(null);
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

    public function moveEndpoint(endpoint:Endpoint,coordinate:Coordinate, mouseDownLocation:Coordinate){
        var object:Object = {"link":null,"component":null,"endPoint":endpoint, "port":null};
        if(object.endPoint != null){

            var xMoveDistance:Float = coordinate.xPosition - mouseDownLocation.xPosition;
            var yMoveDistance:Float = coordinate.yPosition - mouseDownLocation.yPosition;

            var command:Command = new MoveCommand(object,object.endPoint.get_xPosition() + xMoveDistance, object.endPoint.get_yPosition() + yMoveDistance, object.endPoint.get_xPosition(),object.endPoint.get_yPosition(), circuitDiagram);
            commandManager.execute(command);
            redrawCanvas();

            //find the link which contains this endpoint and find the port
            var port:Port = null;
            var linkIndex:Int = -1;
            for(i in 0...circuitDiagram.get_linkArray().length){
                if(circuitDiagram.get_linkArray()[i].get_leftEndpoint() == endpoint){
                    linkIndex = i;
                    if(circuitDiagram.get_linkArray()[i].get_rightEndpoint().get_port() != null){//find the port
                        port = circuitDiagram.get_linkArray()[i].get_rightEndpoint().get_port();
                    }
                }

                if(circuitDiagram.get_linkArray()[i].get_rightEndpoint() == endpoint){
                    linkIndex = i;
                    if(circuitDiagram.get_linkArray()[i].get_leftEndpoint().get_port() != null){//find the port
                        port = circuitDiagram.get_linkArray()[i].get_leftEndpoint().get_port();
                    }
                }
            }
            //verify the endpoint step into another component port or not
            var newPort:Port = circuitDiagramUtil.isOnPort(coordinate).port;

            if(circuitDiagram.get_linkArray()[linkIndex].get_leftEndpoint() == endpoint){
                if(newPort != port){
                    circuitDiagram.get_linkArray()[linkIndex].get_leftEndpoint().set_port(newPort);
                    circuitDiagram.get_linkArray()[linkIndex].get_leftEndpoint().updatePosition();
                }else{
                    circuitDiagram.get_linkArray()[linkIndex].get_leftEndpoint().set_port(null);
                }

            }

            if(circuitDiagram.get_linkArray()[linkIndex].get_rightEndpoint() == endpoint){
                if(newPort != port){
                    circuitDiagram.get_linkArray()[linkIndex].get_rightEndpoint().set_port(newPort);
                    circuitDiagram.get_linkArray()[linkIndex].get_rightEndpoint().updatePosition();
                }else{
                    circuitDiagram.get_linkArray()[linkIndex].get_rightEndpoint().set_port(null);
                }
            }

            redrawCanvas();
        }
    }

    public function changeOrientation(component:Component, orientation:Orientation){
        circuitDiagram.setNewOirentation(component, orientation);
        var object:Object = {"link":null,"component":component,"endPoint":null, "port":null};
        redrawCanvas(object);
    }

    public function deleteComponent(component:Component){
        circuitDiagram.deleteComponent(component);
    }

    public function deleteLink(link:Link){
        circuitDiagram.deleteLink(link);
    }

    public function getEndpoint(coordinate:Coordinate):Endpoint{
        return circuitDiagramUtil.pointOnEndpoint(coordinate);
    }

    public function getComponent(coordinate:Coordinate):Component{
        return circuitDiagramUtil.isInComponent(coordinate);
    }

    public function getLink(coordinate:Coordinate):Link{
        return circuitDiagramUtil.isOnLink(coordinate);
    }

    public function hightLightObject(object:Object){
        redrawCanvas(object);
    }

    public function isOnPort(coordinate:Coordinate):Object{
        return circuitDiagramUtil.isOnPort(coordinate);
    }

    public function resetCommandManagerRecordFlag(){
        commandManager.recordFlagRest();
    }

    public function setComponentName(component:Component, name:String){
        circuitDiagram.componentSetName(component, name);
    }

    public function undo(){
        var object:Object = commandManager.undo();
        redrawCanvas(object);
        if(object.component == null && object.link == null){
            updateToolBar.hidden();
        }else{
            updateToolBar.visible();
        }
    }

    public function redo(){
        var object:Object = commandManager.redo();
        redrawCanvas(object);
        if(object.component == null && object.link == null){
            updateToolBar.hidden();
        }else{
            updateToolBar.visible();
        }
    }

    public function redrawCanvas(?object:Object){
        updateCanvas.update(object);
    }
}
