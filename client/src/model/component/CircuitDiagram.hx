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
    var xMin:Float;
    var yMin:Float;
    var xMax:Float;
    var yMax:Float;
    var centrePoint : Coordinate ;
    static var margin:Float = 50;

    public function new( ) {
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
        notifyObservers(this) ;
    }

    public function update(target: ObservableI, ?data:Any) : Void{
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
		this.normalise();
        link.addObserver(this);
        updateBoundingBox() ;
    }

    public function addComponent(component:Component):Void {
        componentArray.push(component);
		this.normalise();
        component.addObserver(this);
        updateBoundingBox() ;
    }

    public function deleteLink(link:Link):Void{
        link.disconnectEndpoints() ;
        linkArray.remove(link);
		this.normalise();
        updateBoundingBox() ;
    }

    public function deleteComponent(component:Component):Void{
        component.disconnectAllPorts() ;
        componentArray.remove(component);
		this.normalise();
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
	
	public function normalise() : Void {
		// For all pairs of connections {c0, c1} such that c0 != c1 and c0 is close to c1
		// if and both contain a port,
			// create a link to connect them
		// else one or both don't contain a port
			// if c0 contains a port, swap c0 and c1
			// move everything in c0 to c1
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
		
		var markedConnections = new Set<Connection>();
		for (connection in connectionSet.iterator()) {
			for (otherConnection in connectionSet.iterator()) {
				if (otherConnection == connection) { continue ; }
				var connectionDistance = Link.pointsDistance(connection.get_xPosition(), connection.get_yPosition(), otherConnection.get_xPosition(), otherConnection.get_yPosition());
				if (connectionDistance <= 5) {
					// here 15 is what is being considered as "close" to each other
					if (connection.aPortIsConnecte() && otherConnection.aPortIsConnecte()) {
						this.addLink(new Link(this, connection.get_xPosition(), connection.get_yPosition(), otherConnection.get_xPosition(), otherConnection.get_yPosition()));
					} else {
						if (connection.aPortIsConnecte()) {
							var temp = connection ; 
							connection = otherConnection; 
							otherConnection = temp;
							for (element in connection.get_connectedElements()) {
								otherConnection.connect(Std.downcast(element, Connectable));
							}
							//markedConnections.push(connection);
						}
					}
					
					
				} 
			}
		}
		
		// removing marked connections. Unclear is swapping connections in use cases is actually what it is supposed to be.
		// removing such unused connections makes more sense. CHECK ?
		for (connection in markedConnections) {
			connectionSet.remove(connection);
		}
		
		// For all connections c and for all links x not connected to c
		// 		If c is not close to either endpoint of x, but is close to x
        // 			Split x into two links each with an endpoint added to c
		// VERIFY :: Can cause Short circuit!!
		// this carries on with the remaining links
		var removeLinks = new Array<Link>();
		for (connection in connectionSet.iterator()) {
			for (link in this.linkArray) {
				if ((link.get_endpoint(0).getConnection() != connection) && (link.get_endpoint(1).getConnection() != connection)) {
					if (Link.pointToLine(connection.get_xPosition(), connection.get_yPosition(), link.get_endpoint(0).get_xPosition(), link.get_endpoint(0).get_yPosition(), link.get_endpoint(1).get_xPosition(), link.get_endpoint(1).get_yPosition()) <= 5) {
						var link1 = new Link(this, link.get_endpoint(0).get_xPosition(), link.get_endpoint(0).get_yPosition(), connection.get_xPosition(), connection.get_yPosition());
						this.addLink(link1);
						connection.connect(link1.get_endpoint(1));
						var link2 = new Link(this, connection.get_xPosition(), connection.get_yPosition(), link.get_endpoint(1).get_xPosition(), link.get_endpoint(1).get_yPosition());
						this.addLink(link2);
						connection.connect(link2.get_endpoint(0));
						removeLinks.push(link);
					}
				}
			}
		}
		
		for (link in removeLinks) {
			this.deleteLink(link);
		}
		
		var markedLinks = new Array<Link>();
		
		// For all links x:
		//     If both endpoints are in the same connection:
		//         mark x for deletion
		for (link in this.linkArray) {
			if (link.get_endpoint(0).getConnection() == link.get_endpoint(1).getConnection()) {
				markedLinks.push(link);
			}
		}
		
		// delete all marked links
		for (link in markedLinks) {
			this.deleteLink(link);
		}
		markedLinks = new Array<Link>();
		
		// For all remaining links x
		// 		If x is not marked for deletion
		// 			For all links y connected to x.endpoint(0) other than x
		// 				If the other end of y connects to x.endpoint(1)
		// 					Mark y for deletion
		for (link in this.linkArray) {
			for (otherLink in this.linkArray) {
				if (link == otherLink) { continue ; }
				
				if (link.get_endpoint(0).getConnection() == otherLink.get_endpoint(0).getConnection() && link.get_endpoint(1).getConnection() == otherLink.get_endpoint(1).getConnection()) {
					markedLinks.push(otherLink);
				}
				
				if (link.get_endpoint(0).getConnection() == otherLink.get_endpoint(1).getConnection() && link.get_endpoint(1).getConnection() == otherLink.get_endpoint(0).getConnection()) {
					markedLinks.push(otherLink);
				}
			}
		}
		
		// delete all marked links
		for (link in markedLinks) {
			this.deleteLink(link);
		}
		markedLinks = new Array<Link>();
		
		
	}
}