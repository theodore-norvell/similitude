package com.mun.global;
import js.html.CanvasRenderingContext2D;
import com.mun.model.enumeration.Box;
class Constant {
    public static var portRadius:Int = 3;
    public static var pointToLineDistance:Int = 5;
    public static var pointToEndpointDistance:Int = 3;

    public static var BOX_TYPE:Box = Box.BLACK_BOX;
    public static var CONTEXT:CanvasRenderingContext2D = null;
    public function new() {
    }
}
