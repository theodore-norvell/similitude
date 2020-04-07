package model.component;

import js.lib.Object;
import model.attribute.* ;

class StandardAttributes {
    public var orientation(default, null)
        = new Attribute<OrientationAttributeValue>(
            orientation,
            OrientationAttributeType.singleton,
            new OrientationAttributeValue( Orientation.EAST )) ;
}