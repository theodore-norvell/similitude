package com.mun.model.attribute;

import com.mun.model.enumeration.AttrType;
class DelayAttr implements Attribute{
    var name:String="delay";
    var attrType:AttrType;
    var defaultdelay:DelayValue=new DelayValue(0);

    public function new() {
        attrType=AttrType.INT;
    }

    public function getName():String{
        return name;
    }

    public function getdefaultvalue():AttrValue{
        return defaultdelay;
    }

    public function getAttrType():AttrType{
        return attrType;
    }


}
