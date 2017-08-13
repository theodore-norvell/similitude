package com.mun.view.drawingImpl;

import com.mun.view.drawingImpl.DrawingAdapter;
import com.mun.type.Coordinate;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.ORIENTATION;
import js.html.CanvasRenderingContext2D;

/** This class used for drawing the base components
*
*  @author Hui Wan
**/
class DrawingAdapter implements DrawingAdapterI {

    var cxt:CanvasRenderingContext2D;
    var strokeColor:String = "black";//default line color is black
    var fillColor:String = "gray";//default fill color is gray
    var textColor:String = "black";//default text color is black
    var lineWidth:Float = 1.0;//because the defalut line width is 1.0
    var font:String = "8px serif";//initial is 8
    var trans:Transform;

    public function new(transform:Transform, context:CanvasRenderingContext2D) {
        this.trans = transform;
        this.cxt = context;
    }

    public function resetDrawingParam() {
        strokeColor = "black";//default line color is black
        fillColor = "gray";//default fill color is gray
        textColor = "black";//default text color is black
        lineWidth = 1.0;//because the defalut line width is 1.0
        font = "8px serif";//initial is 8
    }

    public function setStrokeColor(color:String):Void {
        strokeColor = color;
    }

    public function setFillColor(color:String):Void {
        fillColor = color;
    }

    public function setTextColor(color:String):Void {
        textColor = color;
    }

    public function setTextFont(font:String):Void {
        this.font = font;
    }

    public function setLineWidth(width:Float):Void {
        cxt.lineWidth = width;
    }

    public function get_cxt():CanvasRenderingContext2D {
        return cxt;
    }

    public function set_cxt(value:CanvasRenderingContext2D):Void {
        this.cxt = value;
    }

    public function getTransform():Transform{
        return this.trans;
    }

    public function transform(transform:Transform):DrawingAdapterI{
        var drawingAdapter:DrawingAdapterI = new DrawingAdapter(transform.compose(trans), cxt);
        return drawingAdapter;
    }

    public function drawAndShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);

        var vCenterCoordinate:Coordinate = trans.pointConvert(new Coordinate(x, y));

        // Make a rectangle from a to (a+b)/2 to (c+d)/2 to d and back to a.
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());
        cxt.lineTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2);
        var cxmin:Float = Math.min(Math.min(r.get_xa(), r.get_xb()), Math.min(r.get_xc(), r.get_xd()));
        var cymin:Float = Math.min(Math.min(r.get_ya(), r.get_yb()), Math.min(r.get_yc(), r.get_yd()));

        var cxmax:Float = Math.max(Math.max(r.get_xa(), r.get_xb()), Math.max(r.get_xc(), r.get_xd()));
        var cymax:Float = Math.max(Math.max(r.get_ya(), r.get_yb()), Math.max(r.get_yc(), r.get_yd()));
        //creat a circle for the AND gate
        //draw the ellipse
        switch (orientation){
            case ORIENTATION.NORTH : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2, 180 * Math.PI / 180, 0, 1 * Math.PI);}
            case ORIENTATION.EAST : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2, 270 * Math.PI / 180, 0, 1 * Math.PI);}
            case ORIENTATION.SOUTH : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2, 0 * Math.PI / 180, 0, 1 * Math.PI);}
            case ORIENTATION.WEST : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2, 90 * Math.PI / 180, 0, 1 * Math.PI);}
            default : {
                //noting. Orientation only have four values
            }
        }
        cxt.lineTo(r.get_xd(), r.get_yd());
        cxt.closePath();
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.lineWidth = lineWidth;
        cxt.fill();
        cxt.stroke();
    }

    public function drawNAndShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);
        var vCenterCoordinate:Coordinate = trans.pointConvert(new Coordinate(x, y));
        // Make a rectangle from a to (a+b)/2 to (c+d)/2 to d and back to a.
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());
        cxt.lineTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2);
        cxt.closePath();

        var cxmin:Float = Math.min(Math.min(r.get_xa(), r.get_xb()), Math.min(r.get_xc(), r.get_xd()));
        var cymin:Float = Math.min(Math.min(r.get_ya(), r.get_yb()), Math.min(r.get_yc(), r.get_yd()));

        var cxmax:Float = Math.max(Math.max(r.get_xa(), r.get_xb()), Math.max(r.get_xc(), r.get_xd()));
        var cymax:Float = Math.max(Math.max(r.get_ya(), r.get_yb()), Math.max(r.get_yc(), r.get_yd()));

        var circleCentreX:Float = (r.get_xb() + r.get_xc()) / 2 ;
        var circleCentreY:Float = (r.get_yb() + r.get_yc()) / 2 ;
        var radius:Float = Math.sqrt((r.get_xb() - r.get_xc()) * (r.get_xb() - r.get_xc()) + (r.get_yb() - r.get_yc()) * (r.get_yb() - r.get_yc())) / 20 ;
        //creat a circle for the AND gate
        //draw the ellipse
        switch (orientation){
            case ORIENTATION.NORTH : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2 - 2 * radius, 180 * Math.PI / 180, 0, 1 * Math.PI);}
            case ORIENTATION.EAST : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2 - 2 * radius, 270 * Math.PI / 180, 0, 1 * Math.PI);}
            case ORIENTATION.SOUTH : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2 - 2 * radius, 0 * Math.PI / 180, 0, 1 * Math.PI);}
            case ORIENTATION.WEST : {
                cxt.ellipse(vCenterCoordinate.get_xPosition(), vCenterCoordinate.get_yPosition(), (cxmax - cxmin) / 2, (cymax - cymin) / 2 - 2 * radius, 90 * Math.PI / 180, 0, 1 * Math.PI);}
            default : {
                //noting. Orientation only have four values
            }
        }
        cxt.lineTo(r.get_xd(), r.get_yd());
        cxt.closePath();

        cxt.moveTo(x + (cymax - cymin) / 2 - 2 * radius, vCenterCoordinate.get_yPosition());
        cxt.arc(x + (cymax - cymin) / 2 - 2 * radius, vCenterCoordinate.get_yPosition(), radius, 0, 2 * Math.PI, false);
        cxt.closePath();

        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.lineWidth = lineWidth;
        cxt.fill();
        cxt.stroke();
    }

    public function drawOrShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());

        // Curve to point (b+c)/2   --- Control point is between a and b
        cxt.quadraticCurveTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2, (r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2);
        // Curve to point d  --- Control point is between c and d
        cxt.quadraticCurveTo((r.get_xc() + r.get_xd()) / 2, (r.get_yc() + r.get_yd()) / 2, r.get_xd(), r.get_yd()) ;
        // Curve to point a
        cxt.quadraticCurveTo(0.25 * (r.get_xa() + r.get_xb() + r.get_xc() + r.get_xd()), 0.25 * (r.get_ya() + r.get_yb() + r.get_yc() + r.get_yd()), r.get_xa(), r.get_ya()) ;

        cxt.closePath();
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.lineWidth = lineWidth;
        cxt.fill();
        cxt.stroke();
    }

    public function drawNOrShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);
        var radius:Float = Math.sqrt((r.get_xb() - r.get_xc()) * (r.get_xb() - r.get_xc()) + (r.get_yb() - r.get_yc()) * (r.get_yb() - r.get_yc())) / 10 ;
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());

        // Curve to point (b+c)/2   --- Control point is between a and b
        cxt.quadraticCurveTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2, (r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2);
        // Curve to point d  --- Control point is between c and d
        cxt.quadraticCurveTo((r.get_xc() + r.get_xd()) / 2, (r.get_yc() + r.get_yd()) / 2, r.get_xd(), r.get_yd()) ;
        // Curve to point a
        cxt.quadraticCurveTo(0.25 * (r.get_xa() + r.get_xb() + r.get_xc() + r.get_xd()), 0.25 * (r.get_ya() + r.get_yb() + r.get_yc() + r.get_yd()), r.get_xa(), r.get_ya()) ;

        cxt.closePath();
        cxt.lineWidth = lineWidth;
        cxt.strokeStyle = strokeColor;
        cxt.fillStyle = fillColor;
        cxt.fill();
        cxt.stroke();
    }

    public function drawBufferShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);
        cxt.beginPath();
        // Start at point a
        cxt.moveTo(r.get_xa(), r.get_ya());
        // Line to point (b+c)/2
        cxt.lineTo((r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2) ;
        // Line to d
        cxt.lineTo(r.get_xd(), r.get_yd()) ;
        // Back to a
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.lineWidth = lineWidth;
        cxt.closePath();
        cxt.fill();
        cxt.stroke();
    }

    public function drawNotShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);
        // Start at point a
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());
        // Line to point (b+c)/2
        cxt.lineTo((r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2) ;
        // Line to d
        cxt.lineTo(r.get_xd(), r.get_yd()) ;
        // Back to a
        cxt.closePath();

        var circleCentreX:Float = (r.get_xb() + r.get_xc()) / 2 ;
        var circleCentreY:Float = (r.get_yb() + r.get_yc()) / 2 ;
        var radius:Float = Math.sqrt((r.get_xb() - r.get_xc()) * (r.get_xb() - r.get_xc()) + (r.get_yb() - r.get_yc()) * (r.get_yb() - r.get_yc())) / 10 ;

        //draw the circle
        switch (orientation){
            case ORIENTATION.NORTH : {
                cxt.arc(circleCentreX, circleCentreY + radius / 2, radius, 0, 2 * Math.PI, false); }
            case ORIENTATION.EAST : {
                cxt.arc(circleCentreX - radius / 2, circleCentreY, radius, 0, 2 * Math.PI, false); }
            case ORIENTATION.SOUTH : {
                cxt.arc(circleCentreX, circleCentreY - radius / 2, radius, 0, 2 * Math.PI, false); }
            case ORIENTATION.WEST : {
                cxt.arc(circleCentreX + radius / 2, circleCentreY, radius, 0, 2 * Math.PI, false); }
            default : {
                //noting. Orientation only have four values
            }
        }
        cxt.lineWidth = lineWidth;
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.fill();
        cxt.stroke();
    }

    public function drawXorShape(x:Float, y:Float, width:Float, height:Float, orientation:ORIENTATION):Void {
        var r:Box = new Box(x, y, width, height, orientation,trans);
        var vCenterCoordinate:Coordinate = trans.pointConvert(new Coordinate(x, y));
        cxt.beginPath();
        cxt.moveTo(r.get_xa(), r.get_ya());

        // Curve to point (b+c)/2   --- Control point is between a and b
        cxt.quadraticCurveTo((r.get_xa() + r.get_xb()) / 2, (r.get_ya() + r.get_yb()) / 2, (r.get_xb() + r.get_xc()) / 2, (r.get_yb() + r.get_yc()) / 2);
        // Curve to point d  --- Control point is between c and d
        cxt.quadraticCurveTo((r.get_xc() + r.get_xd()) / 2, (r.get_yc() + r.get_yd()) / 2, r.get_xd(), r.get_yd()) ;
        // Curve to point a
        cxt.quadraticCurveTo(0.25 * (r.get_xa() + r.get_xb() + r.get_xc() + r.get_xd()), 0.25 * (r.get_ya() + r.get_yb() + r.get_yc() + r.get_yd()), r.get_xa(), r.get_ya()) ;
        cxt.closePath();
        cxt.lineWidth = lineWidth;
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.fill();
        // Curve from (a+d)/8 to (a+d)/8 * 7
        switch (orientation){
            case ORIENTATION.NORTH : {
                cxt.moveTo(r.get_xa() + (r.get_xb() - r.get_xa()) / 8, r.get_ya());
                cxt.quadraticCurveTo(vCenterCoordinate.get_xPosition(),vCenterCoordinate.get_yPosition()  + (r.get_yc() - r.get_yb())/7, r.get_xa() + (r.get_xb() - r.get_xa()) / 8 * 7, r.get_ya());
            };
            case ORIENTATION.SOUTH : {
                cxt.moveTo(r.get_xa() - (r.get_xb() - r.get_xa()) / 8, r.get_ya());
                cxt.quadraticCurveTo(vCenterCoordinate.get_xPosition(),vCenterCoordinate.get_yPosition()  - (r.get_yc() - r.get_yb())/7, r.get_xa() - (r.get_xb() - r.get_xa()) / 8 * 7, r.get_ya());
            };
            case ORIENTATION.WEST : {
                cxt.moveTo(r.get_xa(), r.get_ya() - (r.get_xb() - r.get_xa()) / 8);
                cxt.quadraticCurveTo(vCenterCoordinate.get_xPosition() + (r.get_xb() - r.get_xa())/7,vCenterCoordinate.get_yPosition(), r.get_xa(), r.get_ya() - (r.get_xb() - r.get_xa()) / 8 * 7);
            };
            case ORIENTATION.EAST : {
                cxt.moveTo(r.get_xa(), r.get_ya() + (r.get_xb() - r.get_xa()) / 8);
                cxt.quadraticCurveTo(vCenterCoordinate.get_xPosition() - (r.get_xb() - r.get_xa())/7,vCenterCoordinate.get_yPosition(), r.get_xa(), r.get_ya() + (r.get_xb() - r.get_xa()) / 8 * 7);
            };
            default : {
                //do nothing
            }
        }
        cxt.stroke();
    }

    public function drawRect(x:Float, y:Float, width:Float, height:Float):Void {
        var wnw:Coordinate = new Coordinate(x - width/2, y - height/2);
        var wse:Coordinate = new Coordinate(x + width/2, y + height/2);

        var vnw:Coordinate = trans.pointConvert(wnw);
        var vse:Coordinate = trans.pointConvert(wse);

        var x0:Float = vnw.get_xPosition();
        var y0:Float = vnw.get_yPosition();
        var x1:Float = vse.get_xPosition();
        var y1:Float = vse.get_yPosition();
        cxt.rect(Math.min(x0, x1), Math.min(y0, y1), Math.abs(x1 - x0), Math.abs(y1 - y0));
        cxt.lineWidth = lineWidth;
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.fillRect(Math.min(x0, x1), Math.min(y0, y1), Math.abs(x1 - x0), Math.abs(y1 - y0));
        cxt.stroke();
    }

    public function drawText(str:String, x:Float, y:Float, width:Float):Void {
        var wCoordinate:Coordinate = new Coordinate(x - width/2, y);
        var eCoordinate:Coordinate = new Coordinate(x + width/2, y);

        var vwCoordinate:Coordinate = trans.pointConvert(wCoordinate);
        var veCoordinate:Coordinate = trans.pointConvert(eCoordinate);

        var x0:Float = vwCoordinate.get_xPosition();
        var y0:Float = vwCoordinate.get_yPosition();

        cxt.lineWidth = lineWidth;
        cxt.font = font;
        cxt.fillStyle = textColor;
        cxt.strokeStyle = strokeColor;
        cxt.fillText(str, x0, y0, veCoordinate.get_xPosition() - vwCoordinate.get_xPosition());
    }

    public function drawCricle(x:Float, y:Float, radius:Float):Void {
        var wnw:Coordinate = new Coordinate(x - radius, y);
        var wse:Coordinate = new Coordinate(x + radius, y);

        var vnw:Coordinate = trans.pointConvert(wnw);
        var vse:Coordinate = trans.pointConvert(wse);

        radius = (vse.get_xPosition() - vnw.get_xPosition())/2;

        var x0:Float = vnw.get_xPosition() + radius;
        var y0:Float = vse.get_yPosition();

        cxt.beginPath();
        cxt.arc(x0, y0, radius, 0, 2 * Math.PI, false);
        cxt.closePath;
        cxt.lineWidth = lineWidth;
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.fill();
        cxt.stroke();
    }

    public function drawLine(x0:Float, y0:Float, x1:Float, y1:Float):Void {
        var coordinate0:Coordinate = trans.pointConvert(new Coordinate(x0, y0));
        var coordinate1:Coordinate = trans.pointConvert(new Coordinate(x1, y1));

        var x0:Float = coordinate0.get_xPosition();
        var y0:Float = coordinate0.get_yPosition();
        var x1:Float = coordinate1.get_xPosition();
        var y1:Float = coordinate1.get_yPosition();
        cxt.beginPath();
        cxt.moveTo(x0, y0);
        cxt.lineTo(x1, y1);
        cxt.closePath();
        cxt.lineWidth = lineWidth;
        cxt.fillStyle = fillColor;
        cxt.strokeStyle = strokeColor;
        cxt.fill();
        cxt.stroke();
    }
}
