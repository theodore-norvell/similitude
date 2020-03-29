package model.component;

/**
 * Link consist of two endpoints
 * @author wanhui
 *
 */
import type.HitObject;
import global.Constant.*;
import model.enumeration.MODE;
import type.Coordinate;
import view.drawComponents.DrawComponent;
import view.drawComponents.DrawLink;
import model.drawingInterface.DrawingAdapterI;

class Link extends CircuitElement {
    var leftEndpoint:Endpoint;
    var rightEndpoint:Endpoint;

    public function new(circuitDiagram : CircuitDiagramI, leftEndpoint:Endpoint, rightEndpoint:Endpoint ) {
        super(circuitDiagram) ;
        this.leftEndpoint = leftEndpoint;
        this.rightEndpoint = rightEndpoint;
    }

    public function getLinkLength():Float{
        return Math.sqrt(Math.pow(Math.abs(leftEndpoint.get_xPosition() - rightEndpoint.get_xPosition()),2) +
                        Math.pow(Math.abs(leftEndpoint.get_yPosition() - rightEndpoint.get_yPosition()),2));
    }
	
	public function getCircuitDiagram() : CircuitDiagramI {
		return this.cd ;
	}
	
    public function get_leftEndpoint():Endpoint {
        return leftEndpoint;
    }

    public function set_leftEndpoint(value:Endpoint) {
        return this.leftEndpoint = value;
    }

    public function get_rightEndpoint():Endpoint {
        return rightEndpoint;
    }

    public function set_rightEndpoint(value:Endpoint) {
        return this.rightEndpoint = value;
    }

    override public function left() : Float {
        return Math.min( this.rightEndpoint.get_xPosition(),
                         this.leftEndpoint.get_xPosition() ) ; }

    override public function right() : Float { 
        return Math.max( this.rightEndpoint.get_xPosition(),
                         this.leftEndpoint.get_xPosition() ) ; }

    override public function top() : Float { 
        return Math.min( this.rightEndpoint.get_yPosition(),
                         this.leftEndpoint.get_yPosition() ) ; }

    override public function bottom() : Float { 
        return Math.max( this.rightEndpoint.get_yPosition(),
                         this.leftEndpoint.get_yPosition() ) ; }

    public function drawLink(drawingAdapter:DrawingAdapterI, highLight:Bool){
        var drawComponent:DrawComponent = new DrawLink(this, drawingAdapter);
        if(highLight){
            drawComponent.drawCorrespondingComponent("red");
        }else{
            drawComponent.drawCorrespondingComponent("black");
        }
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
            if(pointsDistance(leftEndpoint.get_xPosition(), leftEndpoint.get_yPosition(),
            coordinate.get_xPosition(), coordinate.get_yPosition()) <= pointToEndpointDistance){
                return leftEndpoint;
            }

            if(pointsDistance(rightEndpoint.get_xPosition(), rightEndpoint.get_yPosition(),
            coordinate.get_xPosition(), coordinate.get_yPosition()) <= pointToEndpointDistance){
                return rightEndpoint;
            }

        return null;
    }

    /**
    * verify this coordinate on link or not
    * @param coordinate
    * @return if the coordinate on the link then return the link
    *           or  return null;
    **/
    function isOnLink(coordinate:Coordinate):Link{

        if(pointToLine(leftEndpoint.get_xPosition(), leftEndpoint.get_yPosition(),
        rightEndpoint.get_xPosition(), rightEndpoint.get_yPosition(),
        coordinate.get_xPosition(), coordinate.get_yPosition()) <= pointToLineDistance){
            //if the distance between the point to line less equal to 3, that means the line should be selected
            //only process the first link met

            //the mouse location should be a little away from the endpoint
            //because in case of it confuse about select endpoint or link
            var theDistanaceToLeftEndpoint = Math.sqrt(
                Math.pow(Math.abs(coordinate.get_xPosition() - leftEndpoint.get_xPosition()), 2) +
                Math.pow(Math.abs(coordinate.get_yPosition() - leftEndpoint.get_yPosition()), 2)
            );

            var theDistanceToRightEndpoint = Math.sqrt(
                Math.pow(Math.abs(coordinate.get_xPosition() - rightEndpoint.get_xPosition()), 2) +
                Math.pow(Math.abs(coordinate.get_yPosition() - rightEndpoint.get_yPosition()), 2)
            );
            if(theDistanaceToLeftEndpoint >= theDistanceToRightEndpoint){
                if(theDistanceToRightEndpoint >= pointToEndpointDistance){
                    return this;
                }
            }else{
                if(theDistanaceToLeftEndpoint >= pointToEndpointDistance){
                    return this;
                }
            }

        }
        return null;
    }

    //the distance of point (x0,y0) to line [(x1,y1),(x2,y2)]
    function pointToLine(x1:Float, y1:Float, x2:Float, y2:Float, x0:Float, y0:Float):Float{
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
    function pointsDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float{
        var lineLength:Float = 0;
        lineLength = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
        return lineLength;
    }

    public function createJSon():String{
        var jsonString:String = "{ \"leftEndpoint\": " + leftEndpoint.createJSon() + ",";
        jsonString += "\"rightEndpoint\": " + rightEndpoint.createJSon();
        jsonString += "}";

        return jsonString;
    }
}
