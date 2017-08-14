package com.mun.model.component;

import js.html.CanvasRenderingContext2D;
import com.mun.type.HitObject;
import com.mun.model.enumeration.POINT_MODE;
import com.mun.model.enumeration.MODE;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.type.LinkAndComponentAndEndpointAndPortArray;
import com.mun.controller.command.CommandManager;
import com.mun.controller.command.Stack;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.type.Coordinate;
import com.mun.type.WorldPoint;

class CircuitDiagram implements CircuitDiagramI{
    var componentArray:Array<Component> = new Array<Component>();
    var linkArray:Array<Link> = new Array<Link>();
    var name:String;//the name of this circuit diagram
    var copyStack:Stack;
    var commandManager:CommandManager;
    var componentArrayReverseFlag:Bool = false;
    var linkArrayReverseFlag:Bool = false;

    //circuit diagram has its width height
    var diagramWidth:Float;
    var diagramHeight:Float;
    //initial the margin
    var xMin:Float;
    var yMin:Float;
    var xMax:Float;
    var yMax:Float;
    var margin:Int;
    var componentAndLinkCenter:Coordinate;

    public function new() {
        copyStack = new Stack();
        componentAndLinkCenter = new Coordinate(0, 0);
        this.margin = 50;
    }

    public function computeDiagramSize():Void{
        xMin = 99999999 ;
        yMin = 99999999 ;
        xMax = 0 ;
        yMax = 0 ;

        for(i in componentArray){
            if(i.get_xPosition() - i.get_width()/2 < xMin){
                xMin = i.get_xPosition() - i.get_width()/2;
            }

            if(i.get_xPosition() + i.get_width()/2 > xMax){
                xMax = i.get_xPosition() + i.get_width()/2;
            }

            if(i.get_yPosition() - i.get_height()/2 < yMin){
                yMin = i.get_yPosition() - i.get_height()/2;
            }

            if(i.get_yPosition() + i.get_height()/2 > yMax){
                yMax = i.get_yPosition() + i.get_height()/2;
            }
        }

        for(i in linkArray){
            //left endpoint
            if(i.get_leftEndpoint().get_xPosition() < xMin){
                xMin = i.get_leftEndpoint().get_xPosition();
            }

            if(i.get_leftEndpoint().get_xPosition() > xMax){
                xMax = i.get_leftEndpoint().get_xPosition();
            }

            if(i.get_leftEndpoint().get_yPosition() < yMin){
                yMin = i.get_leftEndpoint().get_yPosition();
            }

            if(i.get_leftEndpoint().get_yPosition() > yMax){
                yMax = i.get_leftEndpoint().get_yPosition();
            }
            //right endpoint
            if(i.get_rightEndpoint().get_xPosition() < xMin){
                xMin = i.get_rightEndpoint().get_xPosition();
            }

            if(i.get_rightEndpoint().get_xPosition() > xMax){
                xMax = i.get_rightEndpoint().get_xPosition();
            }

            if(i.get_rightEndpoint().get_yPosition() < yMin){
                yMin = i.get_rightEndpoint().get_yPosition();
            }

            if(i.get_rightEndpoint().get_yPosition() > yMax){
                yMax = i.get_rightEndpoint().get_yPosition();
            }
        }

        componentAndLinkCenter.set_xPosition((xMin + xMax)/2);
        componentAndLinkCenter.set_yPosition((yMin + yMax)/2);

        diagramWidth = xMax - xMin + margin;
        diagramHeight = yMax - yMin + margin;

        if(diagramHeight > diagramWidth){
            diagramWidth = diagramHeight;
        }else{
            diagramHeight = diagramWidth;
        }
    }

    public function getComponentAndLinkCenterCoordinate():Coordinate{
        return componentAndLinkCenter;
    }

    public function get_diagramWidth():Float {
        return diagramWidth;
    }

    public function get_diagramHeight():Float {
        return diagramHeight;
    }

    public function get_xMin():Float {
        return xMin;
    }

    public function get_yMin():Float {
        return yMin;
    }

    public function get_xMax():Float {
        return xMax;
    }

    public function get_yMax():Float {
        return yMax;
    }

    public function get_commandManager():CommandManager {
        return commandManager;
    }

    public function set_commandManager(value:CommandManager):Void{
        this.commandManager = value;
    }

    public function get_componentIterator():Iterator<Component>{
        if(componentArrayReverseFlag){
            componentArrayReverse();
        }
        return componentArray.iterator();
    }

    public function get_componentReverseIterator():Iterator<Component>{
        if( ! componentArrayReverseFlag){
            componentArrayReverse();
        }
        return componentArray.iterator();
    }

    function componentArrayReverse(){
        componentArrayReverseFlag = !componentArrayReverseFlag;
        componentArray.reverse();
    }

    public function get_linkIterator():Iterator<Link>{
        if(linkArrayReverseFlag){
            linkArrayReverse();
        }
        return linkArray.iterator();
    }

    public function get_linkReverseIterator():Iterator<Link>{
        if( ! linkArrayReverseFlag ){
            linkArrayReverse();
        }
        return linkArray.iterator();
    }

    function linkArrayReverse(){
        linkArrayReverseFlag = !linkArrayReverseFlag;
        linkArray.reverse();
    }

    public function get_name():String {
        return name;
    }

    public function set_name(value:String):Void{
        this.name = value;
    }

    public function addLink(link:Link):Void {
        linkArray.push(link);
    }

    public function addComponent(component:Component):Void {
        componentArray.push(component);
    }

    public function removeLink(link:Link):Void {
        linkArray.remove(link);
    }

    public function removeComponent(component:Component):Void {
        componentArray.remove(component);
    }

    public function getCopyStack():Stack{
        return copyStack;
    }

    public function setNewOirentation(component:Component, newOrientation:ORIENTATION):Void{
        for (i in 0...componentArray.length) {
            if (component == componentArray[i]) {
                componentArray[i].set_orientation(newOrientation);
                componentArray[i].updateMoveComponentPortPosition(componentArray[i].get_xPosition(),componentArray[i].get_yPosition());
                linkArraySelfUpdate();
                break;
            }
        }
    }

    public function deleteLink(link:Link):Void{
        linkArray.remove(link);
    }

    public function deleteComponent(component:Component):Void{
        componentArray.remove(component);
        //delete port setted in the link
        for(i in component.get_inportIterator()){
            for(j in 0...linkArray.length){
                if(i == linkArray[j].get_leftEndpoint().get_port()){
                    linkArray[j].get_leftEndpoint().set_port(null);
                }

                if(i == linkArray[j].get_rightEndpoint().get_port()){
                    linkArray[j].get_rightEndpoint().set_port(null);
                }

            }
        }
        //
        for(i in component.get_outportIterator()){
            for(j in 0...linkArray.length){
                if(i == linkArray[j].get_leftEndpoint().get_port()){
                    linkArray[j].get_leftEndpoint().set_port(null);
                }

                if(i == linkArray[j].get_rightEndpoint().get_port()){
                    linkArray[j].get_rightEndpoint().set_port(null);
                }

            }
        }
    }

    /**
    * because component may update the port position, so the link should update all of the port connect to the component port
    **/
    function linkArraySelfUpdate():Void{
        for(i in 0...linkArray.length){
            linkArray[i].get_leftEndpoint().updatePosition();
            linkArray[i].get_rightEndpoint().updatePosition();
        }
    }

    public function componentSetName(component:Component, name:String):Void{
        componentArray[componentArray.indexOf(component)].set_name(name);
    }

    /**
    * for all components, if want to draw it, must convert world coordinate to view coordinate first.
     * because draw() method only has the responsiblity to draw component itself.
    **/
    public function draw(drawingAdapter:DrawingAdapterI,?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray, ?context:CanvasRenderingContext2D):Void{
        var drawFlag:Bool = false;
        //update component array
        for(i in componentArray){
            if(linkAndComponentArray != null && linkAndComponentArray.getComponentIteratorLength() != 0){
                for(j in linkAndComponentArray.get_componentIterator()){
                    if(j == i){
                        i.drawComponent(drawingAdapter, true, context);
                        drawFlag = true;
                    }
                }
            }

            if(!drawFlag){
                if(i.getNameOfTheComponentKind() != "CC"){
                    i.drawComponent(drawingAdapter, false);
                }else{
                    i.drawComponent(drawingAdapter, false, linkAndComponentArray, context);
                }
            }

            drawFlag = false;
        }

        drawFlag = false;
        //update link array
        for(i in linkArray){
            if(linkAndComponentArray != null && linkAndComponentArray.getLinkIteratorLength() != 0){
                for(j in linkAndComponentArray.get_linkIterator()){
                    if(j == i){
                        i.drawLink(drawingAdapter, true);
                        drawFlag = true;
                    }
                }
            }

            if(!drawFlag){
                i.drawLink(drawingAdapter, false);
            }

            drawFlag = false;
        }
    }

    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();
        var hitLinkArray:Array<HitObject> = new Array<HitObject>();
        for(i in linkArray){
            hitLinkArray = i.findHitList(coordinate, mode);
            for(j in hitLinkArray){
                j.set_circuitDiagram(this);

                hitObjectArray.push(j);
            }
        }

        var result:Array<HitObject> = new Array<HitObject>();
        for(i in componentArray){
            result = i.findHitList(coordinate, mode) ;

            for(j in result){
                if(j.get_circuitDiagram() == null){
                    j.set_circuitDiagram(this);
                }
                hitObjectArray.push(j);
            }
        }
        return hitObjectArray;
    }

    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        var worldPointArray:Array<WorldPoint> = new Array<WorldPoint>();

        for(i in componentArray){
            var tempWorldPointArray:Array<WorldPoint> = i.findWorldPoint(worldCoordinate, mode);
            for(j in tempWorldPointArray){
                worldPointArray.push(j);
            }
            if(worldPointArray.length != 0){
                break;
            }
        }

        if(worldPointArray.length == 0 || mode == POINT_MODE.PATH){
            worldPointArray.push(new WorldPoint(this, worldCoordinate));
        }
        return worldPointArray;
    }

    public function isEmpty():Bool{
        if(componentArray.length == 0 && linkArray.length == 0){
            return true;
        }else{
            return false;
        }
    }

    public function createJSon():String{
        var jsonString:String = "{ \"name\": \"" + this.name + "\",";
        jsonString += "\"diagramWidth\": \"" + this.diagramWidth + "\",";
        jsonString += "\"diagramHeight\": \"" + this.diagramHeight + "\",";
        jsonString += "\"xMin\": \"" + this.xMin + "\",";
        jsonString += "\"yMin\": \"" + this.yMin + "\",";
        jsonString += "\"xMax\": \"" + this.xMax + "\",";
        jsonString += "\"yMax\": \"" + this.yMax + "\",";

        jsonString += "\"ComponentArray\":[";
        for(i in 0...componentArray.length){
            jsonString += componentArray[i].createJSon();
            if(i != componentArray.length -1){
                jsonString += ",";
            }
        }
        jsonString += "],";

        jsonString += "\"LinkArray\":[";
        for(i in 0...linkArray.length){
            jsonString += linkArray[i].createJSon();
            if(i != linkArray.length -1){
                jsonString += ",";
            }
        }
        jsonString += "]}";
        return jsonString;
    }
}