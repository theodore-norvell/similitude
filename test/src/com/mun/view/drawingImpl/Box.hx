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

        var wne = new Coordinate( x_position - width/2.0, y_position - height / 2.0 ) ;
        var wsw = new Coordinate( x_position + width/2.0, y_position + height / 2.0 ) ;
        var vne:Coordinate = worldToView.convertCoordinate( wne ) ;
        var vsw:Coordinate = worldToView.convertCoordinate( wsw ) ;

        var x0:Float = vne.get_xPosition() ;
        var y0:Float = vne.get_yPosition() ;
        var x1:Float = vsw.get_xPosition() ;
        var y1:Float = vsw.get_yPosition() ;
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
