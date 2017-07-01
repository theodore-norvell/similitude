package com.mun.view.drawingImpl;
import com.mun.type.Type.Coordinate;

class Rectangle implements RectangleI{
    var minCoordinate:Coordinate;
    var maxCoordinate:Coordinate;
    var width_:Float;
    var height_:Float;


    public function new(minCoordinate:Coordinate, maxCoordinate:Coordinate) {
        this.minCoordinate = minCoordinate;
        this.maxCoordinate = maxCoordinate;
    }

    public function min():Coordinate {
        return minCoordinate;
    }

    public function max():Coordinate {
        return maxCoordinate;
    }

    public function width():Float{
        return width_;
    }

    public function height():Float{
        return height_;
    }

    public function set_minCoordinate(value:Coordinate) :Void{
        this.minCoordinate = value;
        updateWidthAndHeight();
    }

    public function set_maxCoordinate(value:Coordinate) :Void{
        this.maxCoordinate = value;
        updateWidthAndHeight();
    }

    function updateWidthAndHeight(){
        width_ = maxCoordinate.xPosition - minCoordinate.xPosition;
        height_ = maxCoordinate.yPosition - minCoordinate.yPosition;
    }
}
