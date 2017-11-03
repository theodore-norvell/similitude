package com.mun.model.attribute;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.AttrType;
import sys.db.Object;
class OrientationValue implements AttrValue{
    var Orientation:ORIENTATION;
    var AttrType:AttrType=AttrType.ORIENTATION;
    public function new(or:ORIENTATION) {
        Orientation=or;
    }

    public function getvalue():Object{
        return Orientation;

    }

    public function getType():AttrType{
        return AttrType;
    }
}
