package model.component;
//import js.html.CanvasRenderingContext2D;
import haxe.ds.GenericStack;
import type.HitObject;
import model.enumeration.POINT_MODE;
import type.Coordinate;
import type.Set;
import type.WorldPoint;
import model.enumeration.MODE;
import model.selectionModel.SelectionModel ;
import model.drawingInterface.DrawingAdapterI;
import model.enumeration.Orientation;
import model.observe.ObservableI ;
/**
* interface for CicuitDiagram
**/
interface CircuitDiagramI extends ObservableI {

    public function checkInvariant(): Void ;
    /**
    * @:getter component array from the circuit diagram
     * @return the iterator
    **/
    public function get_componentIterator():Iterator<Component>;

    /**
    * @:getter link array from the circuit diagram
     * @return the iterator
    **/
    public function get_linkIterator():Iterator<Link>;

    /**
    * add one link
    **/
    public function addLink(link:Link):Void;

    /**
    * add one component
    **/
    public function addComponent(component:Component):Void;

    /**
    * delete one link
    **/
    public function deleteLink(link:Link):Void;

    /**
    * delete one component
    **/
    public function deleteComponent(component:Component):Void;

    /**
    * get the width of this diagram
    **/
    public function get_diagramWidth():Float;

    /**
    * get the height of this diagram
    **/
    public function get_diagramHeight():Float;

    /**
    * get min x
    **/
    public function get_xMin():Float;

    /**
    * get min y
    **/
    public function get_yMin():Float;

    /**
    * get x max
    **/
    public function get_xMax():Float;

    /**
    * get y max
    **/
    public function get_yMax():Float;

    public function get_centre():Coordinate;

    /** 
     * Does the circuit diagram have a component with this name.
     * @param name 
     * @return Bool
     */
    public function hasComponent( name : String ) : Bool ;

    /**
     * Get a component by its name.
     * Precondition: hasComponent( name )
     * 
     * @param name 
     * @return Component
     */
    public function getComponent( name : String ) : Component ;

    /** Compute a component name that hasn't been used yet in this diagram
     *  
     * Postcondition: !hasComponent( result ) 
     * 
     * @param prefix 
     * @return String
     */
    public function getUnusedComponentName( prefix : String ) : String ;

    /**
     * Draw the diagram using the given adapter.
     * 
     * @param drawingAdapter 
     * @param selected 
     */
    public function draw( drawingAdapter:DrawingAdapterI,
                          selected: SelectionModel ):Void;

    /**
    * find the hit list
    * TODO replace this method with one that uses a SelectionModel.
    * TODO Get rid of the HitObject class.
    **/
    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>;

    /**
    * Find all coordinates a point corresponds to.
    * This can be used when there is a mouse click on a circuit. The view
    * would transform the view coordinate to a world coordinate and then call
    * this methods.
    * 
    * Normally this  method just returns a world point that consistst of this diagram
    * and the input coordinate. However when a point is inside a (white box) compound component, the
    * point also refers to a coordinate within that compound component.  So in that case
    * there are two points (at least) that could have been intended by the mouse click.
    * And there could be more beneath that.
    * 
    * When mode is POINT_MODE.ONE, only one world point is returned.
    * 
    * When mode is POINT_MODE.PATH, all the world points are returned. In no particular order.
    **/
    public function findWorldPoint(worldCoordinate:Coordinate, mode:POINT_MODE):Array<WorldPoint>;

	/**
	 * Performs normalisation for the entire circuit.
	 * 
	 * Normallization is a process of tidying up a cicuit diagram so that the way it is matches the way it looks. 
	 * Generally normalization is done at the end of each user interaction that might change the diagram. 
	 * A diagram might become denormailzed in the middle of an interaction, but at the end, it should be normal again.
	 * 
	 * A normal diagram has the following properties.
	 * 
	 *	 Any two distinct connections that are close to each other, both contain a port.
	 *	 Any two disctinct connections that are close to each other (and therefor both contain ports) must be connected by a link.
	 *	 No connection is close to a link unless it includes an endpoint of that link.
	 *	 No link has two endpoints that are directly connected to each other.
	 *	 No two links connect the same pair of connections.
	 */
	public function normalise() : Void;
	
	/**
	 * Get all the connections in a circuitdiagram
	 * @return
	 */
	public function getConnections() : Set<Connection>;
}
