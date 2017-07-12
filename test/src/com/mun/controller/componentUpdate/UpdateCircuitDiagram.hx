package com.mun.controller.componentUpdate;

import com.mun.view.drawingImpl.Transform;
import com.mun.controller.command.DeleteCommand;
import com.mun.controller.command.OrientationCommand;
import com.mun.model.component.Endpoint;
import com.mun.model.component.Link;
import com.mun.controller.command.MoveCommand;
import com.mun.type.Object;
import com.mun.controller.command.Command;
import com.mun.controller.command.AddCommand;
import com.mun.controller.command.CommandManager;
import com.mun.model.gates.ComponentKind;
import com.mun.model.enumeration.Orientation;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.type.Coordinate;
import com.mun.type.LinkAndComponentArray;
import com.mun.type.LinkAndComponentAndEndpointArray;

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

    var linkAndComponentArray:LinkAndComponentArray;

    var transform:Transform;

    public function new(circuitDiagram:CircuitDiagramI) {
        linkAndComponentArray = new LinkAndComponentArray();

        this.circuitDiagram = circuitDiagram;

        commandManager = new CommandManager();
        circuitDiagramUtil = new CircuitDiagramUtil(circuitDiagram);

        transform = Transform.identity();
    }

    public function get_transform():Transform {
        return transform;
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
        var object:Object = new Object();
        object.set_component(component);

        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);
        linkAndComponentArrayReset();

        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function createComponent(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:Orientation, inportNum:Int):Component{
        var componentkind_:ComponentKind = Type.createInstance(Type.resolveClass("com.mun.model.gates." + name),[]);
        var component_:Component = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        component_.setNameOfTheComponentKind(name);

        if(component_.getNameOfTheComponentKind() == "Input" || component_.getNameOfTheComponentKind() == "Output"){
            var inputCounter:Int = 0 ;
            var outputCounter:Int = 0 ;

            for(i in circuitDiagram.get_componentIterator()){
                if(i.getNameOfTheComponentKind() == "Input"){
                    i.get_componentKind().set_sequence(inputCounter);
                    inputCounter++;
                }else if(i.getNameOfTheComponentKind() == "Output"){
                    i.get_componentKind().set_sequence(outputCounter);
                    outputCounter++;
                }else {
                    //other component doesn't need this parameter
                }
            }
        }
        return component_;
    }

    public function addLink(coordinateFrom:Coordinate, coordinateTo:Coordinate):Link{
        var object:Object = new Object();
        object = isOnPort(coordinateFrom);
        if(object.get_port() != null){
            var leftEndpoint:Endpoint = new Endpoint(object.get_port().get_xPosition(), object.get_port().get_yPosition());
            var rightEndpoint:Endpoint = new Endpoint(object.get_port().get_xPosition(), object.get_port().get_yPosition());
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            link.get_leftEndpoint().set_port(object.get_port());
            link.get_rightEndpoint().set_port(null);
            object.set_link(link);
            object.set_endPoint(null);
        }else{
            var leftEndpoint:Endpoint = new Endpoint(coordinateFrom.get_xPosition(), coordinateFrom.get_yPosition());
            var rightEndpoint:Endpoint = new Endpoint(coordinateTo.get_xPosition()+100, coordinateTo.get_yPosition()+100);
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            object.set_link(link);
        }
        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);

        linkAndComponentArrayReset();
        linkAndComponentArray.get_linkArray().push(object.get_link());

        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
        return object.get_link();
    }

    public function moveSelectedObjects(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointArray, currentMouseLocation:Coordinate, mouseDownLocation:Coordinate, mouseLocationFlag:Bool){

        var xMoveDistance:Float = currentMouseLocation.get_xPosition() - mouseDownLocation.get_xPosition();
        var yMoveDistance:Float = currentMouseLocation.get_yPosition() - mouseDownLocation.get_yPosition();

        if(mouseLocationFlag){
            linkAndComponentAndEndpointArray.get_componentArray()[0].set_xPosition(currentMouseLocation.get_xPosition());
            linkAndComponentAndEndpointArray.get_componentArray()[0].set_yPosition(currentMouseLocation.get_yPosition());
        }

        var command:Command = new MoveCommand(linkAndComponentAndEndpointArray, xMoveDistance, yMoveDistance, circuitDiagram);
        commandManager.execute(command);
        //those wires which link to this component should move either, which automactilly completed while move endpoint
        linkAndComponentArray.set_linkArray(linkAndComponentAndEndpointArray.get_linkArray());
        linkAndComponentArray.set_componentArray(linkAndComponentAndEndpointArray.get_componentArray());

        if(linkAndComponentAndEndpointArray.get_endponentArray().length != 0){
            //find the corresponding link
            for(i in circuitDiagram.get_linkIterator()){
                //every time only one endpoint can be move, so the array only have one element
                if(i.get_leftEndpoint() == linkAndComponentAndEndpointArray.get_endponentArray()[0]
                    || i.get_rightEndpoint() == linkAndComponentAndEndpointArray.get_endponentArray()[0]){
                    linkAndComponentArray.addLink(i);
                    break;//one endpoint only belongs to 1 link
                }
            }
        }
        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function changeOrientation(componentArray:Array<Component>, orientation:Orientation){
        var orientationCommand:Command = new OrientationCommand(componentArray, orientation);
        commandManager.execute(orientationCommand);
        var linkAndComponentArray:LinkAndComponentArray = new LinkAndComponentArray();
        linkAndComponentArray.set_componentArray(componentArray);
        updateToolBar.update(linkAndComponentArray);
        circuitDiagram.linkArraySelfUpdate();
        hightLightObject(linkAndComponentArray);
    }

    public function deleteObject(linkAndComponentArray:LinkAndComponentArray){
        var deleteCommand:Command = new DeleteCommand(linkAndComponentArray, circuitDiagram);
        commandManager.execute(deleteCommand);

        redrawCanvas(linkAndComponentArray);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function deleteLink(link:Link){
        circuitDiagram.deleteLink(link);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function getEndpoint(coordinate:Coordinate):Array<Endpoint>{
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
        if(linkAndComponentArray.get_componentArray().length == 0 && linkAndComponentArray.get_linkArray().length == 0){
            updateToolBar.hidden();
        }else{
            updateToolBar.visible();
        }

        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function redo(){
        var linkAndComponentArray:LinkAndComponentArray = commandManager.redo();
        redrawCanvas(linkAndComponentArray);
        if(linkAndComponentArray.get_componentArray().length == 0 && linkAndComponentArray.get_linkArray().length == 0){
            updateToolBar.hidden();
        }else{
            updateToolBar.visible();
        }

        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
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
        linkAndComponentArray.clean();
    }

    public function update(){

        for(i in circuitDiagram.get_linkIterator()){
            i.get_leftEndpoint().updatePosition();
            i.get_rightEndpoint().updatePosition();
        }
    }
}
