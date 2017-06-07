package com.mun.controller.componentUpdate;

import com.mun.controller.command.DeleteCommand;
import com.mun.controller.command.OrientationCommand;
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
import com.mun.type.Type.LinkAndComponentArray;
import com.mun.type.Type.LinkAndComponentAndEndpointArray;

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
    @:isVar var commandManager(get, null):CommandManager;
    var circuitDiagramUtil:CircuitDiagramUtil;
    var updateToolBar:UpdateToolBar;

    var linkAndComponentArray:LinkAndComponentArray = {"linkArray":null, "componentArray":null};

    public function new(circuitDiagram:CircuitDiagramI) {
        this.circuitDiagram = circuitDiagram;

        commandManager = new CommandManager();
        circuitDiagramUtil = new CircuitDiagramUtil(circuitDiagram);
    }

    public function get_commandManager():CommandManager {
        return commandManager;
    }

    public function setUpdateCanvas(updateCanvas:UpdateCanvas){
        this.updateCanvas = updateCanvas;
    }

    public function setUpdateToolBar(updateToolBar:UpdateToolBar){
        this.updateToolBar = updateToolBar;
    }

    public function createComponentByCommand(component:Component){
        var object:Object = {"link":null,"component":component,"endPoint":null, "port":null};
        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);

        linkAndComponentArrayReset();
//        linkAndComponentArray.componentArray = new Array<Component>();
//        linkAndComponentArray.componentArray.push(object.component);
//
//        updateToolBar.update(linkAndComponentArray);
//        hightLightObject(linkAndComponentArray);
    }

    public function createComponent(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:Orientation, inportNum:Int):Component{
        var componentkind_:ComponentKind = Type.createInstance(Type.resolveClass("com.mun.model.gates." + name),[]);
        var component_:Component = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        component_.setNameOfTheComponentKind(name);
        return component_;
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

        linkAndComponentArrayReset();
        linkAndComponentArray.linkArray.push(object.link);

        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
        return object.link;
    }

    public function moveSelectedObjects(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointArray, currentMouseLocation:Coordinate, mouseDownLocation:Coordinate, mouseLocationFlag:Bool){

        var xMoveDistance:Float = currentMouseLocation.xPosition - mouseDownLocation.xPosition;
        var yMoveDistance:Float = currentMouseLocation.yPosition - mouseDownLocation.yPosition;

        if(mouseLocationFlag){
            linkAndComponentAndEndpointArray.componentArray[0].set_xPosition(currentMouseLocation.xPosition);
            linkAndComponentAndEndpointArray.componentArray[0].set_yPosition(currentMouseLocation.yPosition);
        }

        var command:Command = new MoveCommand(linkAndComponentAndEndpointArray, xMoveDistance, yMoveDistance, circuitDiagram);
        commandManager.execute(command);
        //those wires which link to this component should move either, which automactilly completed while move endpoint
        linkAndComponentArray.linkArray = linkAndComponentAndEndpointArray.linkArray;
        linkAndComponentArray.componentArray = linkAndComponentAndEndpointArray.componentArray;

        if(linkAndComponentAndEndpointArray.endpointArray.length != 0){
            //find the corresponding link
            for(i in circuitDiagram.get_linkIterator()){
                //every time only one endpoint can be move, so the array only have one element
                if(i.get_leftEndpoint() == linkAndComponentAndEndpointArray.endpointArray[0]
                    || i.get_rightEndpoint() == linkAndComponentAndEndpointArray.endpointArray[0]){
                    linkAndComponentArray.linkArray.push(i);
                    break;//one endpoint only belongs to 1 link
                }
            }
        }

        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
    }

    public function changeOrientation(componentArray:Array<Component>, orientation:Orientation){
        var orientationCommand:Command = new OrientationCommand(componentArray, orientation);
        commandManager.execute(orientationCommand);
        var linkAndComponentArray:LinkAndComponentArray = {"linkArray":null, "componentArray":componentArray};
        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
    }

    public function deleteObject(linkAndComponentArray:LinkAndComponentArray){
        var deleteCommand:Command = new DeleteCommand(linkAndComponentArray, circuitDiagram);
        commandManager.execute(deleteCommand);

        redrawCanvas(linkAndComponentArray);
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

    public function hightLightObject(linkAndComponentArray:LinkAndComponentArray){
        redrawCanvas(linkAndComponentArray);
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
        var linkAndComponentArray:LinkAndComponentArray = commandManager.undo();
        redrawCanvas(linkAndComponentArray);
        if(linkAndComponentArray.componentArray == null && linkAndComponentArray.linkArray == null){
            updateToolBar.hidden();
        }else{
            updateToolBar.visible();
        }
    }

    public function redo(){
        var linkAndComponentArray:LinkAndComponentArray = commandManager.redo();
        redrawCanvas(linkAndComponentArray);
        if(linkAndComponentArray.componentArray == null && linkAndComponentArray.linkArray == null){
            updateToolBar.hidden();
        }else{
            updateToolBar.visible();
        }
    }

    public function setRedoButton(){
        if(commandManager.getRedoStackSize() == 0){
            updateToolBar.setRedoButtonDisability(true);
        }else{
            updateToolBar.setRedoButtonDisability(false);
        }
    }

    public function setUndoButton(){
        if(commandManager.getUndoStackSize() == 0){
            updateToolBar.setUndoButtonDisability(true);
        }else{
            updateToolBar.setUndoButtonDisability(false);
        }
    }

    public function redrawCanvas(?linkAndComponentArray:LinkAndComponentArray){
        updateCanvas.update(linkAndComponentArray);
        setRedoButton();
        setUndoButton();
    }

    public function linkAndComponentArrayReset(){
        linkAndComponentArray.linkArray = new Array<Link>();
        linkAndComponentArray.componentArray = new Array<Component>();
    }
}
