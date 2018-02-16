package com.mun.model.attribute;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.AttrType;
class OrientationValue implements AttrValue{
    var orientation:ORIENTATION;
    var attrType:AttrType;
    public function new(or:ORIENTATION) {
        orientation=or;
        attrType=AttrType.Orientation;
    }

    public function getvalue():Dynamic{
        return orientation;

    }

    public function getType():AttrType{
        return attrType;
    }
}
