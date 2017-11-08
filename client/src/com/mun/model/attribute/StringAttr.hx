package com.mun.model.attribute;
import com.mun.model.enumeration.AttrType;
class StringAttr implements Attribute{
    var name:String="name";
    var attrType:AttrType;
    var defaultname:StringValue=new StringValue("");

    public function new() {
        attrType=AttrType.STRING;
    }

    public function getName():String{
        return name;
    }

    public function getdefaultvalue():AttrValue{
        return defaultname;
    }

    public function getAttrType():AttrType{
        return attrType;
    }


}
