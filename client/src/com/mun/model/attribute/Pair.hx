package com.mun.model.attribute;
import com.mun.model.component.Component;
interface Pair {
    public function getAttr():Attribute;
    public function getAttrValue():AttrValue;
    public function canupdate(c:Component,n:AttrValue):Bool;
    public function putAttr(c:Component,n:AttrValue):Bool;
}
