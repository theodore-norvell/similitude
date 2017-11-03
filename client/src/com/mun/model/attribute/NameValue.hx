package com.mun.model.attribute;
import com.mun.model.enumeration.AttrType;

class NameValue implements AttrValue{
    var name:String;

    public function new(s:String) {
        name=s;
    }

    public function getValue(): Dynamic {
        return name;

    }

    public function getStringValue(): String {
        return name;
    }

    public function getType():AttrType{
        return AttrType.STRING;
    }
}