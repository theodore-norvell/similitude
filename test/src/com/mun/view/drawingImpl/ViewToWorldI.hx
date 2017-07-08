package com.mun.view.drawingImpl;
import com.mun.type.Coordinate;
interface ViewToWorldI {
    /** Convert a view coordinate to a world coordinate.
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
