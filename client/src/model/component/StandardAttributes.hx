package model.component;

import model.attribute.* ;
import model.enumeration.Orientation ;

class StandardAttributes {
    static public var orientation(default, null) : Attribute<OrientationAttributeValue>
        = new Attribute<OrientationAttributeValue>(
            "orientation",
            OrientationAttributeType.singleton,
            new OrientationAttributeValue( Orientation.EAST )) ;
}