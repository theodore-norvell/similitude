package model.attribute;
import model.component.Component;
interface Pair {
    public function getAttr():Attribute;
    public function getAttrValue():AttrValue;
    public function canupdate(c:Component,n:AttrValue):Bool;
    public function update(c:Component,n:AttrValue):Bool;
}
