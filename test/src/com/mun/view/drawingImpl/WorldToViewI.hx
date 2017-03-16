package com.mun.view.drawingImpl;
interface WorldToViewI {
    /** Convert a world x coordinate to a view x coordinate.
	 *
	 * @param world_x
	 * @return
	 */
    public function convertX(world_x:Float):Float;

    /** Convert a world y coordinate to a view y  coordinate.
	 *
	 * @param world_y
	 * @return
	 */
    public function convertY(world_y:Float):Float;

    /** Convert a view x coordinate to a world x coordinate.
	 *
	 * @param view_x
	 * @return
	 */
    public function invertX(view_x:Float):Float;

    /** Convert a view y coordinate to a world y coordinate.
	 *
	 * @param view_y
	 * @return
	 */
    public function invertY(view_y:Float):Float;
}
