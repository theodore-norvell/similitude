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

class CircuitDiagram implements CircuitDiagramI implements Observer extends Observable{  
    //var observable:Observable;
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
        //this.observable = new Observable() ;
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
        xMin = Math.POSITIVE_INFINITY ;
        yMin =  Math.POSITIVE_INFINITY ;
        xMax = Math.NEGATIVE_INFINITY ;
        yMax = Math.NEGATIVE_INFINITY ;

        for(i in componentArray){
            xMin = Math.min( xMin, i.left() ) ;
            xMax = Math.max( xMax, i.right() ) ;
            yMin = Math.min( yMin, i.top() ) ;
            yMax = Math.max( yMax, i.bottom() ) ;
        }

        for(i in linkArray){
            xMin = Math.min( xMin, i.left() ) ;
            xMax = Math.max( xMax, i.right() ) ;
            yMin = Math.min( yMin, i.top() ) ;
            yMax = Math.max( yMax, i.bottom() ) ;
        }

        if( xMin == Math.POSITIVE_INFINITY ) xMin = 0 ;
        if( yMin == Math.POSITIVE_INFINITY ) yMin = 0 ;
        if( yMax == Math.NEGATIVE_INFINITY ) yMax = 0 ;
        if( yMax == Math.NEGATIVE_INFINITY ) yMax = 0 ;
        
        if( xMin >= xMax ) xMax = xMin + 1 ;
        if( yMin >= yMax ) yMax = yMin + 1 ;

        xMin = xMin - margin / 2 ;
        yMin = yMin - margin / 2 ;
        xMax = xMax + margin / 2 ;
        yMax = yMax + margin / 2 ;

        centrePoint = new Coordinate( (xMax + xMin) / 2.0, (yMax + yMin) / 2.0 ) ;
        this.notifyObservers(this) ;
    }

    public function update(target: Any, ?data:Dynamic) : Void{
        updateBoundingBox() ; // This will also notify observers.
    }

    public function get_centre() : Coordinate {
        return centrePoint ;
    }

    public function get_diagramWidth() : Float {
        return xMax - xMin ;
    }

    public function get_diagramHeight() : Float {
        return yMax - yMin ;
    }

    public function get_xMin() : Float {
        return xMin ;
    }

    public function get_yMin() : Float {
        return yMin ;
    }

    public function get_xMax() : Float {
        return xMax ;
    }

    public function get_yMax() : Float {
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
        link.disconnectEndpoints() ;
        linkArray.remove(link);
        updateBoundingBox() ;
    }

    public function deleteComponent(component:Component):Void{
        component.disconnectAllPorts() ;
        componentArray.remove(component);
        updateBoundingBox() ;

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

        // The following is just for debugging.
        var centre = get_centre() ;
        var width = get_diagramWidth() - margin ;
        var height = get_diagramHeight() - margin ;
        drawingAdapter.setStrokeColor( "lightgray" ) ;
        drawingAdapter.setFillColor( "white" ) ;
        drawingAdapter.drawRect( centre.get_xPosition(), centre.get_yPosition(), width, height ) ;

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