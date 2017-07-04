package com.mun.view.drawingImpl;
import com.mun.type.Type.Coordinate;

class Rectangle implements RectangleI{
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
        Assert.check( corner0.xPosition != corner1.xPosition ) ;
        Assert.check( corner0.yPosition != corner1.yPosition ) ;
        this.minCoordinate = { "xPosition" : Math.min( corner0.xPosition, corner1.xPosition ),
                               "yPosition" : Math.min( corner0.yPosition, corner1.yPosition )};

        this.maxCoordinate = { "xPosition" : Math.max( corner0.xPosition, corner1.xPosition ),
                               "yPosition" : Math.max( corner0.yPosition, corner1.yPosition )};
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
        width_ = maxCoordinate.xPosition - minCoordinate.xPosition;
        height_ = maxCoordinate.yPosition - minCoordinate.yPosition;
    }
}
