package com.mun.model.attribute;
import com.mun.model.enumeration.AttrType;
import com.mun.model.enumeration.ORIENTATION;
class OrientationAttr {
    var name:String="Orientation";
    var AttrType:AttrType=AttrType.ORIENTATION;
    var defaultOrientation:OrientationValue=new OrientationValue(ORIENTATION.EAST);

    public function new() {
    }

    public function getdefaultvalue():AttrValue{
        return defaultOrientation;
    }

    public function getAttrType():AttrType{
        return AttrType;
    }
}
