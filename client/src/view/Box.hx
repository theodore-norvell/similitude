package view ;

import type.Coordinate;
import model.enumeration.Orientation;
import model.drawingInterface.Transform;

class Box {
    var xa:Float;
    var ya:Float;
    var xb:Float;
    var yb:Float;
    var xc:Float;
    var yc:Float;
    var xd:Float;
    var yd:Float;

    public function new(x_position:Float, y_position:Float, width:Float, height:Float, orientation:Orientation, transform:Transform) {

        var wnw:Coordinate = new Coordinate(x_position - width/2, y_position - height/2);
        var wse:Coordinate = new Coordinate(x_position + width/2, y_position + height/2);

        var vnw:Coordinate = transform.pointConvert(wnw);
        var vse:Coordinate = transform.pointConvert(wse);

        var x0:Float = vnw.get_xPosition();
        var y0:Float = vnw.get_yPosition();
        var x1:Float = vse.get_xPosition();
        var y1:Float = vse.get_yPosition();
        switch (orientation){
            case Orientation.EAST : {
                xa = x0; ya = y0;
                xb = x1; yb = y0;
                xc = x1; yc = y1;
                xd = x0; yd = y1;
            }
            case Orientation.SOUTH : {
                xd = x0; yd = y0;
                xa = x1; ya = y0;
                xb = x1; yb = y1;
                xc = x0; yc = y1;
            }
            case Orientation.WEST : {
                xc = x0; yc = y0;
                xd = x1; yd = y0;
                xa = x1; ya = y1;
                xb = x0; yb = y1;
            }
            case Orientation.NORTH : {
                xb = x0; yb = y0;
                xc = x1; yc = y0;
                xd = x1; yd = y1;
                xa = x0; ya = y1;
            }
            default : {
                //noting. Orientation only have four values
            }
        }
    }

    public function get_xa():Float {
        return xa;
    }

    public function get_ya():Float {
        return ya;
    }

    public function get_xb():Float {
        return xb;
    }

    public function get_yb():Float {
        return yb;
    }

    public function get_xc():Float {
        return xc;
    }

    public function get_yc():Float {
        return yc;
    }

    public function get_xd():Float {
        return xd;
    }

    public function get_yd():Float {
        return yd;
    }

}
