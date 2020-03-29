package model.component;

import assertions.Assert;
import model.observe.Observable;
import model.observe.Observer;
import type.HitObject;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import model.drawingInterface.DrawingAdapterI;
import model.selectionModel.SelectionModel ;
import model.enumeration.ORIENTATION;
import type.Coordinate;
import type.WorldPoint;

class CircuitDiagram implements CircuitDiagramI implements Observer{  
    var observable:Observable;
    var componentArray:Array<Component> = new Array<Component>();
    var linkArray:Array<Link> = new Array<Link>();

    // The bounding box
    var xMin:Float;
    var yMin:Float;
    var xMax:Float;
    var yMax:Float;
    var centrePoint : Coordinate ;
    static var margin:Float = 50;

    public function new( ) {
        this.observable = new Observable() ;
        updateBoundingBox() ;

    }

    public function checkInvariant( ) : Void {
        for( comp in componentArray ) Assert.assert( comp.get_CircuitDiagram() == this ) ;
        for( link in linkArray ) {
            Assert.assert( link.get_CircuitDiagram() == this ) ;
            // TODO Check that any links that connect to ports connect to
            // ports whose component is in the componentarray. 
            // TODO Check that those port are in the same location 
            // as the endpoints.
        }
    }

    public function updateBoundingBox():Void {
        xMin = 0;
        yMin = 0;
        xMax = 0;
        yMax = 0;

        for(i in componentArray){
            xMin = Math.min( xMin, i.left() ) ;
            xMax = Math.max( xMax, i.right() ) ;
            yMin = Math.min( yMin, i.top() ) ;
            yMax = Math.min( yMax, i.bottom() ) ;
        }

        for(i in linkArray){
            xMin = Math.min( xMin, i.left() ) ;
            xMax = Math.max( xMax, i.right() ) ;
            yMin = Math.min( yMin, i.top() ) ;
            yMax = Math.min( yMax, i.bottom() ) ;
        }
        xMin = xMin - margin / 2 ;
        yMin = yMin - margin / 2 ;
        xMax = xMax + margin / 2 ;
        yMax = yMax + margin / 2 ;
        centrePoint = new Coordinate( (xMax + xMin) / 2.0, (yMax + yMin) / 2.0 ) ;
        observable.notifyObservers(this) ;
    }

    public function update(c:Component,?data:Dynamic) : Void{
        updateBoundingBox() ; // This will also notify observers.
    }

    public function get_centre():Coordinate{
        return centrePoint ;
    }

    public function get_diagramWidth():Float {
        return xMax - xMin ;
    }

    public function get_diagramHeight():Float {
        return yMax - yMin ;
    }

    public function get_xMin():Float {
        return xMin ;
    }

    public function get_yMin():Float {
        return yMin ;
    }

    public function get_xMax():Float {
        return xMax ;
    }

    public function get_yMax():Float {
        return yMax ;
    }

    public function get_componentIterator():Iterator<Component> {
        return componentArray.iterator();
    }

    public function get_linkIterator():Iterator<Link> {
        return linkArray.iterator();
    }

    public function addLink(link:Link):Void {
        linkArray.push(link);
        link.addObserver(this);
        updateBoundingBox() ;
    }

    public function addComponent(component:Component):Void {
        componentArray.push(component);
        component.addObserver(this);
        updateBoundingBox() ;
    }

    public function deleteLink(link:Link):Void{
        linkArray.remove(link);
        updateBoundingBox() ;
    }

    public function deleteComponent(component:Component):Void{
        componentArray.remove(component);
        //delete port setted in the link
        for(i in component.get_inportIterator()){
            for(j in 0 ... linkArray.length){
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
            for(j in 0 ... linkArray.length){
                if(i == linkArray[j].get_leftEndpoint().get_port()){
                    linkArray[j].get_leftEndpoint().set_port(null);
                }

                if(i == linkArray[j].get_rightEndpoint().get_port()){
                    linkArray[j].get_rightEndpoint().set_port(null);
                }
            }
        }
        
        updateBoundingBox() ;

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
        // TODO.  It must be enforced that components of a circuit have unique names.
        component.set_name(name);
    }

    /**
    * for all components, if want to draw it, must convert world coordinate to view coordinate first.
     * because draw() method only has the responsiblity to draw component itself.
    **/
    public function draw( drawingAdapter:DrawingAdapterI,
                          selection :SelectionModel)
    : Void{
        //update component array
        for(i in componentArray){
            var highlight = selection.containsComponent( i ) ;
            i.drawComponent(drawingAdapter, highlight, selection);
        }

        for(i in linkArray){
            var highlight = selection.containsLink( i ) ;
            i.drawLink(drawingAdapter, highlight);
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
}