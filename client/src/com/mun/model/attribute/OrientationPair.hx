package com.mun.model.attribute;
import com.mun.model.component.Component;
class OrientationPair implements Pair{
    var OrientationAttr:OrientationAttr;
    var OrientationValue:OrientationValue;
    public function new(na:NameAttr,nv:NameValue) {
        OrientationAttr=na;
        OrientationValue=nv;
    }

    public function getAttr():Attribute{
        return OrientationAttr;

    }

    public function getAttrValue():AttrValue{
        return OrientationValue;
    }

    public function canupdate(c:Component,n:AttrValue):Bool{
        return true;
    }

    public function update(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            OrientationValue=n;
            return true;
        }
        return false;

    }
}
