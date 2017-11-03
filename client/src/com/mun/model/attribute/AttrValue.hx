package com.mun.model.attribute;
import com.mun.model.enumeration.AttrType;
interface AttrValue {
    public function getValue():Dynamic;
    public function getType():AttrType;
}
