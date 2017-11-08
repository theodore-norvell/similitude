package com.mun.model.attribute;

import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.AttrType;
class OrientationAttr implements Attribute{
    var name:String="orientation";
    var attrType:AttrType;
    var defaultOrientation:OrientationValue;

    public function new() {
        attrType=AttrType.Orientation;
        defaultOrientation=new OrientationValue(ORIENTATION.EAST);
    }

    public function getName():String{
        return name;
    }

    public function getdefaultvalue():AttrValue{
        return defaultOrientation;
    }

    public function getAttrType():AttrType{
        return attrType;
    }
}
