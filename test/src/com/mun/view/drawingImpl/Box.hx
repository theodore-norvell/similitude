package com.mun.view.drawingImpl;

import com.mun.type.Coordinate;
import com.mun.model.enumeration.ORIENTATION;
class Box {
    var xa:Float;
    var ya:Float;
    var xb:Float;
    var yb:Float;
    var xc:Float;
    var yc:Float;
    var xd:Float;
    var yd:Float;

    public function new(x_position:Float, y_position:Float, width:Float, height:Float, orientation:ORIENTATION, worldToView:WorldToViewI) {

        var coordinate:Coordinate = worldToView.convertCoordinate(new Coordinate(x_position, y_position));

        var x0:Float = coordinate.get_xPosition() - width / 2;
        var y0:Float = coordinate.get_yPosition() - height / 2;
        var x1:Float = coordinate.get_xPosition() + width / 2;
        var y1:Float = coordinate.get_yPosition() + height / 2;
        switch (orientation){
            case ORIENTATION.EAST : {
                xa = x0; ya = y0;
                xb = x1; yb = y0;
                xc = x1; yc = y1;
                xd = x0; yd = y1;
            }
            case ORIENTATION.SOUTH : {
                xd = x0; yd = y0;
                xa = x1; ya = y0;
                xb = x1; yb = y1;
                xc = x0; yc = y1;
            }
            case ORIENTATION.WEST : {
                xc = x0; yc = y0;
                xd = x1; yd = y0;
                xa = x1; ya = y1;
                xb = x0; yb = y1;
            }
            case ORIENTATION.NORTH : {
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
