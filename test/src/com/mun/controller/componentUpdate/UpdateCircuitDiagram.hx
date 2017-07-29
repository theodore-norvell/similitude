package com.mun.controller.componentUpdate;

import com.mun.model.component.Port;
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
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.Component;
import com.mun.type.Coordinate;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.global.Constant.*;

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
    var updateToolBar:UpdateToolBar;

    var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray;

    var transform:Transform;

    public function new(circuitDiagram:CircuitDiagramI) {
        linkAndComponentArray = new LinkAndComponentAndEndpointAndPortArray();

        this.circuitDiagram = circuitDiagram;

        commandManager = new CommandManager();

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

    public function createComponent(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:ORIENTATION, inportNum:Int):Component{
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
            var rightEndpoint:Endpoint = new Endpoint(coordinateTo.get_xPosition(), coordinateTo.get_yPosition());
            var link:Link = new Link(leftEndpoint,rightEndpoint);
            object.set_link(link);
        }
        var command:Command = new AddCommand(object,circuitDiagram);
        commandManager.execute(command);

        linkAndComponentArrayReset();
        linkAndComponentArray.addLink(object.get_link());

        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
        
        return object.get_link();
    }

    public function moveSelectedObjects(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointAndPortArray, currentMouseLocation:Coordinate, mouseDownLocation:Coordinate, mouseLocationFlag:Bool){

        var xMoveDistance:Float = currentMouseLocation.get_xPosition() - mouseDownLocation.get_xPosition();
        var yMoveDistance:Float = currentMouseLocation.get_yPosition() - mouseDownLocation.get_yPosition();

        if(mouseLocationFlag){
            linkAndComponentAndEndpointArray.getComponentFromIndex(0).set_xPosition(currentMouseLocation.get_xPosition());
            linkAndComponentAndEndpointArray.getComponentFromIndex(0).set_yPosition(currentMouseLocation.get_yPosition());
        }

        var command:Command = new MoveCommand(linkAndComponentAndEndpointArray, xMoveDistance, yMoveDistance, circuitDiagram);
        commandManager.execute(command);
        //those wires which link to this component should move either, which automactilly completed while move endpoint
        linkAndComponentArray.clean();
        for(i in linkAndComponentAndEndpointArray.get_linkIterator()){
            linkAndComponentArray.addLink(i);
        }

        for(i in linkAndComponentAndEndpointArray.get_componentIterator()){
            linkAndComponentArray.addComponent(i);
        }

        if(linkAndComponentAndEndpointArray.getEndppointIteratorLength() != 0){
            //find the corresponding link
            for(i in circuitDiagram.get_linkIterator()){
                //every time only one endpoint can be move, so the array only have one element
                if(i.get_leftEndpoint() == linkAndComponentAndEndpointArray.getEndpointFromIndex(0)
                    || i.get_rightEndpoint() == linkAndComponentAndEndpointArray.getEndpointFromIndex(0)){
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

    public function changeOrientation(componentIterator:Iterator<Component>, orientation:ORIENTATION){
        var componentArray:Array<Component> = new Array<Component>();
        var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
        for(i in componentIterator){
            componentArray.push(i);
            linkAndComponentArray.addComponent(i);
        }
        var orientationCommand:Command = new OrientationCommand(componentArray, orientation, circuitDiagram);
        commandManager.execute(orientationCommand);

        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
    }

    public function deleteObject(linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        var deleteCommand:Command = new DeleteCommand(linkAndComponentArray, circuitDiagram);
        commandManager.execute(deleteCommand);
        redrawCanvas(linkAndComponentArray);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function hightLightObject(linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
        redrawCanvas(linkAndComponentArray);
    }

    public function resetCommandManagerRecordFlag(){
        commandManager.recordFlagRest();
    }

    public function setComponentName(component:Component, name:String){
        circuitDiagram.componentSetName(component, name);
    }

    public function undo(){
        var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray = commandManager.undo();
        redrawCanvas(linkAndComponentArray);

        if(linkAndComponentArray.getComponentIteratorLength() == 1){
            updateToolBar.visible(true);
        }else{
            updateToolBar.hidden();
        }

        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
    }

    public function redo(){
        var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray = commandManager.redo();
        redrawCanvas(linkAndComponentArray);
        if(linkAndComponentArray.getComponentIteratorLength() == 0 && linkAndComponentArray.getLinkIteratorLength() == 0){
            updateToolBar.hidden();
        }else{
            if(linkAndComponentArray.getComponentIteratorLength() == 1){
                updateToolBar.visible(true);
            }else{
                updateToolBar.visible(false);
            }
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

    public function redrawCanvas(?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray){
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

    /**
    * prediction: the endpoint must be exsited
    **/
    public function findLinkThroughEndpoint(endpoint:Endpoint):Link{
        for(i in circuitDiagram.get_linkIterator()){
            if(i.get_rightEndpoint() == endpoint){
                return i;
            }else if(i.get_leftEndpoint() == endpoint){
                return i;
            }
        }
        return null;
    }

    /**
    * verify this coordinate on port or not
    * @param coordinate
    * @return if the coordinate on the port then return the port
    *           or  return null;
    **/
    function isOnPort(cooridnate:Coordinate):Object{
        var object:Object = new Object();
        for(i in circuitDiagram.get_componentIterator()){
            for(j in i.get_inportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.set_port(j);
                    for(k in circuitDiagram.get_linkIterator()){
                        object.set_endPoint(isLinkOnPort(k,j));
                        return object;
                    }
                }
            }
            for(j in i.get_outportIterator()){
                if(isInCircle(cooridnate, j.get_xPosition(), j.get_yPosition())){
                    //the mouse on the port
                    //verify is there any link link to this port
                    object.set_port(j);
                    for(k in circuitDiagram.get_linkIterator()){
                        object.set_endPoint(isLinkOnPort(k,j));
                        return object;
                    }
                }
            }
        }
        return object;
    }

    /**
    * verify the link on the port or not
     * @param link
     * @param port
     * @return endpoint   if one of the endpoint on the port, then return this endpoint
     *                          or return null
    **/
    function isLinkOnPort(link:Link, port:Port):Endpoint{
        var endpoint:Endpoint = null;
        //if this port has a endpoint (left)
        if(isEndpointOnPort(link.get_leftEndpoint(), port)){
            endpoint = link.get_leftEndpoint();
        }
        //if this port has a endpoint (right)
        if(isEndpointOnPort(link.get_rightEndpoint(), port)){
            endpoint = link.get_rightEndpoint();
        }
        return endpoint;
    }

    /**
    * verify a point is in a circuit or not
     * @param coordinate     the point need to be verified
     * @param orignalXPosition   the circuit x position
     * @param orignalYPosition   the circuit y position
     * @return if in the circle, return true; otherwise, return false;
    **/
    function isInCircle(coordinate:Coordinate, orignalXPosition:Float, orignalYPosition:Float):Bool{
        //the radius is 3
        if(Math.abs(coordinate.get_xPosition() - orignalXPosition) <= portRadius && Math.abs(coordinate.get_yPosition() - orignalYPosition) <= portRadius){
            return true;
        }else{
            return false;
        }
    }

    /**
    * verify the endpoint on the port or not
     * @param endpoint
     * @param port
     * @return Bool   if the endpoint on the port, return true; otherwise, return false;
    **/
    function isEndpointOnPort(endpoint:Endpoint, port:Port):Bool{
        if(endpoint.get_xPosition() == port.get_xPosition() && endpoint.get_yPosition() == port.get_yPosition()){
            return true;
        }else{
            return false;
        }
    }
}
