package model.component;

import assertions.Assert;
import model.observe.*;
import type.HitObject;
import model.enumeration.POINT_MODE;
import model.enumeration.MODE;
import model.drawingInterface.DrawingAdapterI;
import model.selectionModel.SelectionModel ;
import model.enumeration.Orientation;
import type.Coordinate;
import type.WorldPoint;
import type.Set;

class CircuitDiagram extends Observable implements CircuitDiagramI implements Observer{  
    var componentArray:Array<Component> = new Array<Component>();
    var linkArray:Array<Link> = new Array<Link>();

    // The bounding box
    var xMin:Float = 0 ;
    var yMin:Float = 0;
    var xMax:Float = 1 ;
    var yMax:Float = 1 ;
    var centrePoint : Coordinate ;
    static var margin:Float = 50;

    public function new( ) {
        updateBoundingBox() ;
    }

    public function toString() : String {
        return "CircuitDiagram( components: " + componentArray
                         + " links:" + linkArray + ")" ;
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
        var newXMin = Math.POSITIVE_INFINITY ;
        var newYMin =  Math.POSITIVE_INFINITY ;
        var newXMax = Math.NEGATIVE_INFINITY ;
        var newYMax = Math.NEGATIVE_INFINITY ;

        for(i in componentArray){
            newXMin = Math.min( newXMin, i.left() ) ;
            newYMin = Math.min( newYMin, i.top() ) ;
            newXMax = Math.max( newXMax, i.right() ) ;
            newYMax = Math.max( newYMax, i.bottom() ) ;
        }

        for(i in linkArray){
            newXMin = Math.min( newXMin, i.left() ) ;
            newYMin = Math.min( newYMin, i.top() ) ;
            newXMax = Math.max( newXMax, i.right() ) ;
            newYMax = Math.max( newYMax, i.bottom() ) ;
        }

        if( newXMin == Math.POSITIVE_INFINITY ) newXMin = 0 ;
        if( newYMin == Math.POSITIVE_INFINITY ) newYMin = 0 ;
        if( newXMax == Math.NEGATIVE_INFINITY ) newXMax = 0 ;
        if( newYMax == Math.NEGATIVE_INFINITY ) newYMax = 0 ;
        
        if( newXMin >= newXMax ) newXMax = newXMin + 1 ;
        if( newYMin >= newYMax ) newYMax = newYMin + 1 ;

        newXMin = newXMin - margin / 2 ;
        newYMin = newYMin - margin / 2 ;
        newXMax = newXMax + margin / 2 ;
        newYMax = newYMax + margin / 2 ;

        if( newXMin != xMin || newYMin != yMin
         || newXMax != xMax || newYMax != yMax ) {
            xMin = newXMin ;
            yMin = newYMin ;
            xMax = newXMax ;
            yMax = newYMax ;
            centrePoint = new Coordinate( (xMax + xMin) / 2.0, (yMax + yMin) / 2.0 ) ;
            notifyObservers(this) ;
        }
    }

    public function update(target: ObservableI, ?data:Any) : Void{
        updateBoundingBox() ; // This will may also notify observers.
        notifyObservers( this, data ) ;
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

    public function hasComponent( name : String ) : Bool {
        for( c in componentArray ) if( c.getName() == name ) return true ;
        return false ;
    }

    public function getComponent( name : String ) : Component {
        // Precondition: It must be there.
        for( c in componentArray ) if( c.getName() == name ) return c ;
        Assert.assert( false ) ;
        return null ;
    }
    
    public function getUnusedComponentName( prefix : String ) : String {
        var i = 0 ;
        while( true ) {
            var name = prefix + i ;
            if( ! hasComponent( name ) ) return name ;
            i += 1 ;
        }
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

        for(i in linkArray){
            var highlight = selection.containsLink( i ) ;
            i.drawLink(drawingAdapter, highlight);
        }

        //update component array
        for(i in componentArray){
            var highlight = selection.containsComponent( i ) ;
            i.drawComponent(drawingAdapter, highlight, selection);
        }

    }

    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();
        
        for(link in linkArray){
            var result = link.findHitList(coordinate, mode);
            for(j in result){
                j.set_circuitDiagram(this);
                hitObjectArray.push(j);
            }
        }

        for(comp in componentArray) {
            var result = comp.findHitList(coordinate, mode) ;
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

    public function getConnections() : Set<Connection> {

		var connectionSet = new Set<Connection>();
		for (link in this.linkArray) {
			connectionSet.push(link.get_endpoint(0).getConnection());
			connectionSet.push(link.get_endpoint(1).getConnection());
		}
		for (component in this.componentArray) {
			var ports = component.get_ports();
			for (port in ports) {
				connectionSet.push(port.getConnection());
			}
        }

        return connectionSet ;
    }
}