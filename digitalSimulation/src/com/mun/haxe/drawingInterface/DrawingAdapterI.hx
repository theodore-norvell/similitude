package com.mun.haxe.drawingInterface;

/**  A drawing adaptor represents a tool for outputting
 *   drawings to a part of a screen or page or similar
 *   device.
 *
 * @author Hui Wan
 *
 */
import com.mun.haxe.enumeration.Orientation;
interface DrawingAdapterI {
    /** Set the line color.  Also used for outlines of shapes.
	 *
	 * @param color like "red" "black" "gray"
	 */
    public function setStrokeColor(color:String) : Void;

    /** Set the fill color for solid objects.
	 *
	 * @param color like "red" "black" "gray"
	 */
	 public function setFillColor(color:String) : Void;

    /** Set the text color.
	 *
	 *  @param color like "red" "black" "gray"
	 */
    public function setTextColor(color:String) : Void;

    /** Set the text font
    *
    *   @param font is the float type, the initial value is 10px
     */
    public function setTextFont(font:String) : Void;

    /** Set the thickness of lines and outlines.
	 *
	 * @param width  -- Width is roughly in world units. I.e. width of 1 is roughly 1 in world units.
	 */
    public function setLineWidth(width : Float) : Void;

    /** Draw an AND gate within a given bounding box.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param width  -- The width in world coordinates.
	 * @param height -- The height in world coordinates.
	 * @param orientation -- The direction of the output.
	 */
    public function drawAndShape(x : Float, y : Float, width : Float, height : Float,  orientation : Orientation) : Void;

    /** Draw an OR gate within a given bounding box.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param width  -- The width in world coordinates.
	 * @param height -- The height in world coordinates.
	 * @param orientation -- The direction of the output.
	 */
    public function drawOrShape(x : Float, y : Float, width : Float, height : Float, orientation : Orientation) : Void;

    /** Draw a buffer (i.e. triangle) within a given bounding box.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param width  -- The width in world coordinates.
	 * @param height -- The height in world coordinates.
	 * @param orientation -- The direction of the output.
	 */
    public function drawBufferShape(x : Float, y : Float, width : Float, height : Float, orientation : Orientation) : Void;

    /** Draw a NOT gate within a given bounding box.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param width  -- The width in world coordinates.
	 * @param height -- The height in world coordinates.
	 * @param orientation -- The direction of the output.
	 */
    public function drawNotShape(x : Float, y : Float, width : Float, height : Float, orientation : Orientation) : Void;

    /** Draw a rectangle.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param width  -- The width in world coordinates.
	 * @param height -- The height in world coordinates.
	 */
    public function drawRect(x : Float, y : Float, width : Float, height : Float) : Void;

    /** Draw a string within a given bounding box.
	 * The string will be drawn horizontally as one line.
	 * The size will be chosen so that the string fits within the box both horizontally and vertically.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param width  -- The width in world coordinates.
	 */
    public function drawText(str : String, x : Float, y : Float, width : Float) : Void;

    /** Draw an ellipse within a given bounding box.
	 *
	 * @param x   -- The distance from the left edge to the centre of the bounding box in world coordinates.
	 * @param y   -- The distance from the top edge to the centre of the bounding box in world coordinates.
	 * @param radius  -- The radius in world coordinates.
	 */
    public function drawCricle(x : Float, y : Float, radius : Float) : Void;

    /** Draw a line between two points in world coordinates.
	 *
	 * @param x0 -- The x coordinate (distance from left edge) of the first point.
	 * @param y0 -- The y coordinate (distance from top edge) of the first point.
	 * @param x1 -- The x coordinate (distance from left edge) of the second point.
	 * @param y1 -- The y coordinate (distance from top edge) of the second point.
	 */
    public function drawLine(x0 : Float, y0 : Float, x1 : Float, y1 : Float) : Void;
}
