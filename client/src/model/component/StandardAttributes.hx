package model.component;

import model.attribute.* ;
import model.enumeration.Orientation ;
import type.TimeUnit ;

class StandardAttributes {
    static public var orientation(default, null) : Attribute<OrientationAttributeValue>
        = new Attribute<OrientationAttributeValue>(
            "orientation",
            new OrientationAttributeValue( Orientation.EAST )) ;

    static public var numberOfInputPorts(default, null) : Attribute<IntegerAttributeValue>
        = new Attribute<IntegerAttributeValue>(
            "input ports",
            new IntegerAttributeValue( 1 )) ;

    static public var delay(default, null) : Attribute<TimeAttributeValue>
        = new Attribute<TimeAttributeValue>(
            "delay",
            new TimeAttributeValue(1, TimeUnit.NANO_SECOND ) ) ;
}