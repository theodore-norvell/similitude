package com.mun.model.attribute;
import sys.db.Object;
import com.mun.model.enumeration.AttrType;
class DelayValue implements AttrValue{
    var delay:Int;
    var AttrType:AttrType=AttrType.INT;
    public function new(d:Int) {
        delay=d;
    }

    public function getvalue():Object{
        return delay;

    }

    public function getType():AttrType{
        return AttrType;
    }
}
