package com.mun.view.drawingImpl;
import com.mun.type.Coordinate;
interface WorldToViewI {
    /** Convert a world coordinate to a view x coordinate.
	 *
	 * @param coordinate
	 * @return
	 */
    public function convertCoordinate(coordinate:Coordinate):Coordinate;

    /**
    * get the transform
    **/
    public function get_transform():Transform;
}
