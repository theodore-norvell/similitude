package model.drawingInterface;
import type.Coordinate;
interface RectangleI {
    /** Returns the smallest x and smallest y of the four corners */
    public function min() : Coordinate;

    /** Returns the largest x and largest y of the four corners */
    public function max() : Coordinate;

    /** Same as max().x - min().x */
    public function width() : Float;

    /** Same as max().y - min().y */
    public function height() : Float;

    /**
    * set min coordinate
    **/
    public function set_minCoordinate(value:Coordinate) :Void;

    /**
    * set max coordinate
    **/
    public function set_maxCoordinate(value:Coordinate) :Void;

}
