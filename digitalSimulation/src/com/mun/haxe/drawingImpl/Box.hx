package com.mun.haxe.drawingImpl;

import com.mun.haxe.enumeration.Orientation;
import com.mun.haxe.drawingInterface.WorldToViewI;
class Box {
    @:isVar var xa(get, null):Float;
    @:isVar var ya(get, null):Float;
    @:isVar var xb(get, null):Float;
    @:isVar var yb(get, null):Float;
    @:isVar var xc(get, null):Float;
    @:isVar var yc(get, null):Float;
    @:isVar var xd(get, null):Float;
    @:isVar var yd(get, null):Float;

    public function new(x_position:Float, y_position:Float, width:Float, height:Float, orientation:Orientation, worldToView : WorldToViewI) {

        var x0:Float = worldToView.convertX(x_position - width / 2);
        var y0:Float = worldToView.convertY(y_position - height / 2);
        var x1:Float = worldToView.invertX(x_position + width / 2);
        var y1:Float = worldToView.invertY(y_position + height / 2);
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
