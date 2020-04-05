package model.attribute;

import model.enumeration.AttrType;
class IntAttr implements Attribute{
    var name:String="delay";
    var attrType:AttrType;
    var defaultdelay:IntValue=new IntValue(0);

    public function new(s:String) {
        name=s;
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
