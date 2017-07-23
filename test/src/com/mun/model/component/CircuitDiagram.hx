package com.mun.model.component;

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
    @:isVar var diagramWidth(get, null):Float;
    @:isVar var diagramHeight(get, null):Float;
    var margin:Float = 100;
    var leastWidthAndHeight:Int = 500;
    //initial the margin
    @:isVar var xMin(get, null):Float;
    @:isVar var yMin(get, null):Float;
    @:isVar var xMax(get, null):Float;
    @:isVar var yMax(get, null):Float;

    public function new() {
        copyStack = new Stack();
    }

    public function computeDiagramSize():Void{
        xMin = 99999999 ;
        yMin = 99999999 ;
        xMax = 0 ;
        yMax = 0 ;

        for(i in componentArray){
            if(i.get_xPosition() < xMin){
                xMin = i.get_xPosition() - i.get_width()/2;
            }

            if(i.get_xPosition() > xMax){
                xMax = i.get_xPosition() + i.get_width()/2;
            }

            if(i.get_yPosition() < yMin){
                yMin = i.get_yPosition() - i.get_height()/2;
            }

            if(i.get_yPosition() > yMax){
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
                xMax = i.get_leftEndpoint().get_xPosition();
            }

            if(i.get_rightEndpoint().get_yPosition() < yMin){
                yMin = i.get_rightEndpoint().get_yPosition();
            }

            if(i.get_rightEndpoint().get_yPosition() > yMax){
                yMax = i.get_rightEndpoint().get_yPosition();
            }
        }

        //$d.width() = d.xmax() - d.xmin() $
        //$d.height() = d.ymax() - d.ymin() $
        diagramWidth = xMax - xMin + margin;
        diagramHeight = yMax - yMin + margin;

        xMax = xMax + margin/2;
        xMin = xMin - margin/2;

        yMax = yMax + margin/2;
        yMin = yMin - margin/2;

        //set the least width and height for diagram
        if(diagramWidth < leastWidthAndHeight){
            //width
            var displacement = leastWidthAndHeight - diagramWidth;
            yMax = yMax + displacement/2;
            yMin = yMin - displacement/2;

            diagramWidth = leastWidthAndHeight;
        }

        if(diagramHeight < leastWidthAndHeight){

            //height
            var displacement = leastWidthAndHeight - diagramHeight;
            xMax = xMax + displacement/2;
            xMin = xMin - displacement/2;

            diagramHeight = leastWidthAndHeight;
        }
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

    public function clearCopyStack():Void{
        copyStack.clearStack();
    }

    public function pushLinkToCopyStack(link:Link):Void{
        copyStack.pushLink(link);
    }

    public function pushComponentToCopyStack(component:Component):Void{
        copyStack.pushComponent(component);
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
    public function draw(drawingAdapter:DrawingAdapterI,?linkAndComponentArray:LinkAndComponentAndEndpointAndPortArray):Void{
        var drawFlag:Bool = false;
        //update component array
        for(i in componentArray){
            if(linkAndComponentArray.getComponentIteratorLength() != 0){
                for(j in linkAndComponentArray.get_componentIterator()){
                    if(j == i){
                        i.drawComponent(drawingAdapter, true);
                        drawFlag = true;
                    }
                }
            }

            if(!drawFlag){
                i.drawComponent(drawingAdapter, false);
            }

            drawFlag = false;
        }

        drawFlag = false;
        //update link array
        for(i in linkArray){
            if(linkAndComponentArray.getLinkIteratorLength() != 0){
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

    public function findHitList(coordinate:Coordinate, mode:MODE):LinkAndComponentAndEndpointAndPortArray{
        var linkAndComponentAndEndpointAndPortArray:LinkAndComponentAndEndpointAndPortArray = new LinkAndComponentAndEndpointAndPortArray();
        for(i in linkArray){
            var result:LinkAndComponentAndEndpointAndPortArray = i.findHitList(coordinate, mode) ;

            for(j in result.get_linkIterator()){
                linkAndComponentAndEndpointAndPortArray.addLink(j);
            }

            for(j in result.get_endpointIterator()){
                linkAndComponentAndEndpointAndPortArray.addEndpoint(j);
            }
//            linkAndComponentAndEndpointAndPortArray.get_linkArray().concat(result.get_linkArray());
//            linkAndComponentAndEndpointAndPortArray.get_endponentArray().concat(result.get_endponentArray());
        }

        for(i in componentArray){
            var result:LinkAndComponentAndEndpointAndPortArray = i.findHitList(coordinate, mode) ;

            for(j in result.get_linkIterator()){
                linkAndComponentAndEndpointAndPortArray.addLink(j);
            }

            for(j in result.get_endpointIterator()){
                linkAndComponentAndEndpointAndPortArray.addEndpoint(j);
            }

            for(j in result.get_componentIterator()){
                linkAndComponentAndEndpointAndPortArray.addComponent(j);
            }

            for(j in result.get_portIterator()){
                linkAndComponentAndEndpointAndPortArray.addPort(j);
            }

//            linkAndComponentAndEndpointAndPortArray.get_componentArray().concat(result.get_componentArray());
//            linkAndComponentAndEndpointAndPortArray.get_linkArray().concat(result.get_linkArray());
//            linkAndComponentAndEndpointAndPortArray.get_endponentArray().concat(result.get_endponentArray());
//            linkAndComponentAndEndpointAndPortArray.get_portArray().concat( result.get_portArray());
        }
        return linkAndComponentAndEndpointAndPortArray;
    }

    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>{
        var worldPointArray:Array<WorldPoint> = new Array<WorldPoint>();

        for(i in componentArray){
            worldPointArray.concat(i.findWorldPoint(worldCoordinate, mode));
            if(worldPointArray.length != 0){
                break;
            }
        }

        if(worldPointArray.length == 0 || mode == POINT_MODE.PATH){
            worldPointArray.push(new WorldPoint(this, worldCoordinate));
        }
        return worldPointArray;
    }
}
