package com.mun.view.drawingImpl;


class WorldToView implements WorldToViewI {
    var base:Float = 1;//base number is 1

    public function new(base:Float) {
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

    public function getBase():Float{
        return base;
    }

    public function setBase(base:Float):Void{
        this.base = base;
    }
}
