package model.component;

import model.attribute.* ;
import model.enumeration.Orientation ;

class StandardAttributes {
    static public var orientation(default, null) : Attribute<OrientationAttributeValue>
        = new Attribute<OrientationAttributeValue>(
            "orientation",
            new OrientationAttributeValue( Orientation.EAST )) ;

    static public var numberOfInputPorts(default, null) : Attribute<IntegerAttributeValue>
        = new Attribute<IntegerAttributeValue>(
            "input ports",
            new IntegerAttributeValue( 2 )) ;
}