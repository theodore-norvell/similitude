package com.mun.controller.componentUpdate;

import com.mun.model.component.CircuitDiagramI;
import com.mun.model.component.FolderI;
import com.mun.controller.command.PasteCommand;
import com.mun.controller.command.CopyCommand;
import com.mun.model.component.Component;
import com.mun.model.gates.CompoundComponent;
import com.mun.model.component.Port;
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
    var folder:FolderI;

    var linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray;

    public function new(circuitDiagram:CircuitDiagramI, folder:FolderI) {
        linkAndComponentArray = new LinkAndComponentAndEndpointAndPortArray();
        this.folder = folder;

        this.circuitDiagram = circuitDiagram;

        commandManager = new CommandManager();
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
            //generate a sequence id for every input and ouput component
            var idString:String = Date.now().getFullYear() + "";
            idString += Date.now().getMonth()+ "";
            idString += Date.now().getDay()+ "";
            idString += Date.now().getHours()+ "";
            idString += Date.now().getMinutes()+ "";
            idString += Date.now().getSeconds()+ "";
            idString += Std.random(1000) + "";
            var id:Int = cast idString;
            componentkind_.set_sequence(id);
        }
        return component_;
    }

    public function createCompoundComponent(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:ORIENTATION, inportNum:Int, circuitDiagram:CircuitDiagramI):Component{
        var componentkind_:ComponentKind = new CompoundComponent(circuitDiagram);
        var component_:Component = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        component_.setNameOfTheComponentKind("CC");
        return component_;
    }

    public function addLink(coordinateFrom:Coordinate, coordinateTo:Coordinate, hitCircuitDiagram:CircuitDiagramI):Link{
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
        var command:Command = new AddCommand(object,hitCircuitDiagram);
        commandManager.execute(command);

        linkAndComponentArrayReset();
        linkAndComponentArray.addLink(object.get_link());

        updateToolBar.update(linkAndComponentArray);
        hightLightObject(linkAndComponentArray);
        //compute the size of this diagram
        circuitDiagram.computeDiagramSize();
        
        return object.get_link();
    }

    function copyLink(link:Link, linkandComponentArray:LinkAndComponentAndEndpointAndPortArray, newCreated:LinkAndComponentAndEndpointAndPortArray):Link{
        var leftEndpoint:Endpoint;
        var rightEndpoint:Endpoint;

        if(link.get_leftEndpoint().get_port() == null){
            leftEndpoint = new Endpoint(link.get_leftEndpoint().get_xPosition(), link.get_leftEndpoint().get_yPosition());
        }else{
            leftEndpoint = new Endpoint(link.get_leftEndpoint().get_xPosition(), link.get_leftEndpoint().get_yPosition());
            leftEndpoint.set_port(checkEndpointOnPort(leftEndpoint, newCreated.get_componentIterator()));
        }

        if(link.get_rightEndpoint().get_port() == null){
            rightEndpoint = new Endpoint(link.get_rightEndpoint().get_xPosition(), link.get_rightEndpoint().get_yPosition());
        }else{
            rightEndpoint = new Endpoint(link.get_rightEndpoint().get_xPosition(), link.get_rightEndpoint().get_yPosition());
            rightEndpoint.set_port(checkEndpointOnPort(rightEndpoint, newCreated.get_componentIterator()));
        }

        return new Link(leftEndpoint, rightEndpoint);
    }

    function checkEndpointOnPort(endpoint:Endpoint, componentIterator:Iterator<Component>):Port{
        for(i in componentIterator){
            for(j in i.get_inportIterator()){
                if(isEndpointOnPort(endpoint, j)){
                    return j;
                }
            }

            for(j in i.get_outportIterator()){
                if(isEndpointOnPort(endpoint, j)){
                    return j;
                }
            }
        }

        return null;
    }

    public function copy(linkandComponentArray:LinkAndComponentAndEndpointAndPortArray):LinkAndComponentAndEndpointAndPortArray{
        var result:LinkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
        for(i in linkandComponentArray.get_componentIterator()){
            var component:Component = createComponent(i.getNameOfTheComponentKind(), i.get_xPosition(), i.get_yPosition(), i.get_width(), i.get_height(), i.get_orientation(), i.get_inportsNum());
            result.addComponent(component);
        }

        for(i in linkandComponentArray.get_linkIterator()){
            var link:Link = copyLink(i, linkandComponentArray, result);

            result.addLink(link);
        }
        var command:Command = new CopyCommand(result, circuitDiagram);
        commandManager.execute(command);

        return result;
    }

    public function paste(mouseLocation:Coordinate):LinkAndComponentAndEndpointAndPortArray{
        var linkandComponentArray:LinkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();

        var command:Command = new PasteCommand(mouseLocation.get_xPosition(), mouseLocation.get_yPosition(), circuitDiagram);
        commandManager.execute(command);

        for(i in circuitDiagram.getCopyStack().getLinkArray()){
            linkandComponentArray.addLink(i);
        }

        for(i in circuitDiagram.getCopyStack().getComponentArray()){
            linkandComponentArray.addComponent(i);
        }
        circuitDiagram.getCopyStack().clearStack();
        return linkandComponentArray;
    }

    public function isCopyStackEmpty():Bool{
        if(circuitDiagram.getCopyStack().isStackEmpty()){
            return true;
        }else{
            return false;
        }
    }

    public function findObjectInWhichCircuitDiagram(object:Object):CircuitDiagramI{
        return folder.findObjectBelongsToWhichCircuitDiagram(object);
    }

    function getTheOperateCircuitDiagram(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointAndPortArray):CircuitDiagramI{
        var object:Object = new Object();
        for(i in linkAndComponentAndEndpointArray.get_componentIterator()){
            object.set_component(i);
            break;
        }

        for(i in linkAndComponentAndEndpointArray.get_linkIterator()){
            object.set_link(i);
            break;
        }

        for(i in linkAndComponentAndEndpointArray.get_endpointIterator()){
            object.set_endPoint(i);
            break;
        }

        return folder.findObjectBelongsToWhichCircuitDiagram(object);
    }

    /**
    * precondiction:  all of the stuff in the linkAndComponentAndEndpointArray should belongs to one circuit diagram
    **/
    public function moveSelectedObjects(linkAndComponentAndEndpointArray:LinkAndComponentAndEndpointAndPortArray, currentMouseLocation:Coordinate, mouseDownLocation:Coordinate, mouseLocationFlag:Bool){

        var xMoveDistance:Float = currentMouseLocation.get_xPosition() - mouseDownLocation.get_xPosition();
        var yMoveDistance:Float = currentMouseLocation.get_yPosition() - mouseDownLocation.get_yPosition();

        if(mouseLocationFlag){
            linkAndComponentAndEndpointArray.getComponentFromIndex(0).set_xPosition(currentMouseLocation.get_xPosition());
            linkAndComponentAndEndpointArray.getComponentFromIndex(0).set_yPosition(currentMouseLocation.get_yPosition());
        }

        var moveCircuit:CircuitDiagramI = getTheOperateCircuitDiagram(linkAndComponentAndEndpointArray);

        var command:Command = new MoveCommand(linkAndComponentAndEndpointArray, xMoveDistance, yMoveDistance, moveCircuit);
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
