package model.component;

/**
 * Link consist of two endpoints
 * @author wanhui
 *
 */
import model.observe.*;
import type.HitObject;
import global.Constant.portSize;
import global.Constant.pointToLineDistance ;
import model.enumeration.MODE;
import type.Coordinate;
import model.drawComponents.DrawComponent;
import model.drawComponents.DrawLink;
import model.drawingInterface.DrawingAdapterI;

class Link extends CircuitElement implements Observer {
    var endpoints : Array<Endpoint>;


    public function new(circuitDiagram : CircuitDiagramI, x0 : Float, y0 : Float, x1 : Float, y1 : Float ) {
        super(circuitDiagram) ;
        var zero = new Endpoint(circuitDiagram, x0, y0) ;
        var one = new Endpoint(circuitDiagram, x1, y1) ;
        one.addObserver(this) ;
        zero.addObserver(this) ;
        this.endpoints = [zero, one];
    }

    public function toString() : String {
        return "Link(from:" + endpoints[0] + " to " + endpoints[1] +")" ;
    }

    public function update(target : ObservableI,?data: Any) : Void {
        notifyObservers( this ) ;
    }

    public function disconnectEndpoints() : Void {
        this.endpoints[0].disconnect() ;
        this.endpoints[1].disconnect() ;
    }

    public function getLinkLength():Float{
        return Math.sqrt(Math.pow(Math.abs(endpoints[0].get_xPosition() - endpoints[1].get_xPosition()),2) +
                        Math.pow(Math.abs(endpoints[0].get_yPosition() - endpoints[1].get_yPosition()),2));
    }
	
	public function getCircuitDiagram() : CircuitDiagramI {
		return this.cd ;
	}
    
    public function get_endpoint( i : Int ) : Endpoint {
        return endpoints[i] ;
    }

    override public function left() : Float {
        return Math.min( this.endpoints[1].get_xPosition(),
                         this.endpoints[0].get_xPosition() ) ; }

    override public function right() : Float { 
        return Math.max( this.endpoints[1].get_xPosition(),
                         this.endpoints[0].get_xPosition() ) ; }

    override public function top() : Float { 
        return Math.min( this.endpoints[1].get_yPosition(),
                         this.endpoints[0].get_yPosition() ) ; }

    override public function bottom() : Float { 
        return Math.max( this.endpoints[1].get_yPosition(),
                         this.endpoints[0].get_yPosition() ) ; }

    public function drawLink(drawingAdapter:DrawingAdapterI, highlight:Bool){
        var drawComponent:DrawLink = new DrawLink(this, drawingAdapter, highlight );
        drawComponent.drawCorrespondingComponent( ) ;
    }

    public function findHitList(coordinate:Coordinate, mode:MODE):Array<HitObject>{
        var hitObjectArray:Array<HitObject> = new Array<HitObject>();

        var link:Link = isOnLink(coordinate);
        if(link != null){
            var hitObject:HitObject = new HitObject();
            hitObject.set_link(link);
            hitObjectArray.push(hitObject);
        }

        var endpoint:Endpoint = pointOnEndpoint(coordinate);
        if(endpoint != null){
            var hitObject:HitObject = new HitObject();
            hitObject.set_endpoint(endpoint);
            hitObjectArray.push(hitObject);
        }

        return hitObjectArray;
    }

    function pointOnEndpoint(coordinate:Coordinate):Endpoint{
            if(   pointsDistance(endpoints[0].get_xPosition(), endpoints[0].get_yPosition(),
                              coordinate.get_xPosition(), coordinate.get_yPosition())
               <= portSize ){
                return endpoints[0];
            }

            if(   pointsDistance(endpoints[1].get_xPosition(), endpoints[1].get_yPosition(),
                              coordinate.get_xPosition(), coordinate.get_yPosition())
               <= portSize){
                return endpoints[1];
            }

        return null;
    }

    /**
    * verify this coordinate on link or not
    * @param coordinate
    * @return if the coordinate on the link, but not close to either end point then return the link
    *           or  return null;
    **/
    public function isOnLink(coordinate:Coordinate):Link{
        // TODO Change this to a boolean function.
        if(pointToLine(endpoints[0].get_xPosition(), endpoints[0].get_yPosition(),
                       endpoints[1].get_xPosition(), endpoints[1].get_yPosition(),
                       coordinate.get_xPosition(), coordinate.get_yPosition()) <= pointToLineDistance ){
            //if the distance between the point to line less equal to pointToLineDistance,
            // that means the line should be selected
            //only process the first link met

            //the mouse location should be a little away from the endpoint
            //because in case of it confuse about select endpoint or link
            var theDistanaceToLeftEndpoint = Math.sqrt(
                Math.pow(Math.abs(coordinate.get_xPosition() - endpoints[0].get_xPosition()), 2) +
                Math.pow(Math.abs(coordinate.get_yPosition() - endpoints[0].get_yPosition()), 2)
            );

            var theDistanceToRightEndpoint = Math.sqrt(
                Math.pow(Math.abs(coordinate.get_xPosition() - endpoints[1].get_xPosition()), 2) +
                Math.pow(Math.abs(coordinate.get_yPosition() - endpoints[1].get_yPosition()), 2)
            );
            if( theDistanceToRightEndpoint >= pointToLineDistance
            && theDistanaceToLeftEndpoint >= pointToLineDistance) {
                    return this;
            } else {
                return null ;
            }
        } else {
            return null ;
        }
    }

    //the distance of point (x0,y0) to line [(x1,y1),(x2,y2)]
    public static function pointToLine(x1:Float, y1:Float, x2:Float, y2:Float, x0:Float, y0:Float):Float{
        var space:Float = 0;
        var a,b,c:Float;

        a = pointsDistance(x1, y1, x2, y2);//the length of the line

        b = pointsDistance(x1, y1, x0, y0);//the distance from point (x0,y0) to (x1,y1)

        c = pointsDistance(x2, y2, x0, y0);//the distance from point (x0,y0) to (x2,y2)

        if(c + b == a){//the point is on the link
            space = 0;
            return space;
        }

        if(a <= 0.00001){//it is not a line, it is a point
            space = b;
            return space;
        }

        if(c * c > a * a + b * b){//Form a rectangular triangle or obtuse angle (x1,y1)
            space = b;
            return space;
        }

        if(b * b >= a * a + c * c){//Form a rectangular triangle or obtuse angle (x2,y2)
            space = c;
            return space;
        }

        //composed of acute angle triangle, then get the height

        var p:Float = (a + b + c) / 2;//circumference of the triangle

        var s:Float = Math.sqrt(p * (p - a) * (p - b) * (p - c));//Helen formula

        space = 2 * s / a;//return distance from point to line (using triangular area formula get the height

        return space;
    }

    //calculate the distance between two points
    public static function pointsDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float{
        var lineLength:Float = 0;
        lineLength = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
        return lineLength;
    }
}
