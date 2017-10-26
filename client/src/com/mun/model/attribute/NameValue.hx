package com.mun.model.attribute;
import sys.db.Object;
import com.mun.model.enumeration.AttrType;
class NameValue implements AttrValue{
    var name:String;
    var AttrType:AttrType=AttrType.STRING;
    public function new(s:String) {
        name=s;
    }

    public function getvalue():Object{
        return name;

    }

    public function getType():AttrType{
        return AttrType;
    }
}