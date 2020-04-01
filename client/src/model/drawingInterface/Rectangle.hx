package model.drawingInterface ;

import type.Coordinate;

class Rectangle {
    // Inv minCoordinate.xPosition < maxCoordinate.xPosition
    // Inv minCoordinate.yPosition < maxCoordinate.yPosition
    var minCoordinate:Coordinate;
    var maxCoordinate:Coordinate;
    // Inv: width_ = maxCoordinate.xPosition - minCoordinate.xPosition
    var width_:Float;
    var height_:Float;

    /**
    * Precondition: corner0.xPosition != corner1.xPosition
    * Precondition: corner0.yPosition != corner1.yPosition
    **/
    public function new(corner0:Coordinate, corner1:Coordinate) {
        this.minCoordinate = new Coordinate(Math.min( corner0.get_xPosition(), corner1.get_xPosition() ),  Math.min( corner0.get_yPosition(), corner1.get_yPosition() ));

        this.maxCoordinate =  new Coordinate(Math.max( corner0.get_xPosition(), corner1.get_xPosition() ),  Math.max( corner0.get_yPosition(), corner1.get_yPosition() ));

        updateWidthAndHeight() ;
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
        width_ = maxCoordinate.get_xPosition() - minCoordinate.get_xPosition();
        height_ = maxCoordinate.get_yPosition() - minCoordinate.get_yPosition();
    }
}
