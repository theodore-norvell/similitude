package com.mun.model.attribute;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.enumeration.AttrType;

class OrientationValue {
    var orientation:ORIENTATION;

    public function new(or:ORIENTATION) {
        orientation=or;
    }


    public function getValue():Dynamic {
        return orientation;

    }

    public function getOrientation() : ORIENTATION
        return orientation ;

    public function getType():AttrType{
        return AttrType.ORIENTATION;
    }


}
