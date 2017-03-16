package com.mun.view.drawingImpl;


class WorldToView implements WorldToViewI {
    var base:Int = 1;//base number is 1

    public function new(base:Int) {
        this.base = base;
    }

    public function convertX(x:Float):Float {
        return base * x;
    }

    public function convertY(y:Float):Float {
        return base * y;
    }

    public function invertX(view_x:Float):Float {
        return base * view_x;
    }

    public function invertY(view_y:Float):Float {
        return base * view_y;
    }
}
