package com.mun.model.attribute;
import com.mun.model.enumeration.AttrType;
class IntValue implements AttrValue{
    var delay:Int;
    var attrType:AttrType;
    public function new(d:Int) {
        delay=d;
        attrType==AttrType.INT;
    }

    public function getvalue():Dynamic{
        return delay;

    }

    public function getType():AttrType{
        return attrType;
    }
}
