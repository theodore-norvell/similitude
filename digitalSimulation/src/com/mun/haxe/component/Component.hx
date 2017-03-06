package com.mun.haxe.component;

import com.mun.haxe.enumeration.Orientation;
import com.mun.haxe.gates.ComponentKind;

/**
 * Component composite by gates and ports, in this class
 * will composite gates and ports into one entity.
 * @author wanhui
 *
 */
class Component {
    @:isVar var xPosition(get, set):Float;//the x position of the component
    @:isVar var yPosition(get, set):Float;//the y position of the component
    @:isVar var height(get, set):Float;//height
    @:isVar var width(get, set):Float;//width
    @:isVar var orientation(get, set):Orientation;//the orientation of the component
    @:isVar var componentKind(get, set):ComponentKind;//the actual gate in this component
    @:isVar var portArray(get, set):Array<Port>;//the ports for the component
    @:isVar var name(get, set):String;//the name of the component

    public function new(xPosition : Float, yPosition: Float, height : Float, width : Float, orientation : Orientation,componentKind : ComponentKind) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        this.height = height;
        this.width = width;
        this.orientation = orientation;
        this.componentKind = componentKind;

    }

    function get_xPosition():Float {
        return xPosition;
    }

    function set_xPosition(value:Float) {
        return this.xPosition = value;
    }

    function get_yPosition():Float {
        return yPosition;
    }

    function set_yPosition(value:Float) {
        return this.yPosition = value;
    }

    function get_orientation():Orientation {
        return orientation;
    }

    function set_orientation(value:Orientation) {
        return this.orientation = value;
    }

    function get_componentKind():ComponentKind {
        return componentKind;
    }

    function set_componentKind(value:ComponentKind) {
        return this.componentKind = value;
    }

    function get_portArray():Array<Port> {
        return portArray;
    }

    function set_portArray(value:Array<Port>) {
        return this.portArray = value;
    }

    function get_name():String {
        return name;
    }

    function set_name(value:String) {
        return this.name = value;
    }

    function get_height():Float {
        return height;
    }

    function set_height(value:Float) {
        return this.height = value;
    }

    function get_width():Float {
        return width;
    }

    function set_width(value:Float) {
        return this.width = value;
    }

}
