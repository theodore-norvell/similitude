package com.mun.model.attribute;

import com.mun.model.enumeration.AttrType;

class DelayValue implements AttrValue{

    var delay:Int;

    public function new(d:Int) {
        delay=d;
    }

    public function getValue():Dynamic{
        return delay;

    }

    public function getIntValue():Int{
        return delay;

    }

    public function getType():AttrType{
        return AttrType.INT;
    }
}
