package com.mun.model.attribute;
import com.mun.model.enumeration.AttrType;
class StringValue implements AttrValue{
    var name:String="";
    public function new(s:String) {
        name=s;
    }

    public function getvalue():Dynamic{
        return name;

    }

    public function getType():AttrType{
        return AttrType.STRING;
    }
}