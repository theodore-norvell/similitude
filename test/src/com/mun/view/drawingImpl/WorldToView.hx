package com.mun.view.drawingImpl;


import com.mun.type.Coordinate;
class WorldToView implements WorldToViewI {
    @:isVar var transform(get, null):Transform;

    public function new(transform:Transform) {
        this.transform = transform;
    }

    /** Convert a world coordinate to a view coordinate.
	 *
	 * @param coordinate
	 * @return
	 */
    public function convertCoordinate(coordinate:Coordinate):Coordinate{
        return transform.pointInvert(coordinate);
    }

    public function get_transform():Transform {
        return transform;
    }
}
