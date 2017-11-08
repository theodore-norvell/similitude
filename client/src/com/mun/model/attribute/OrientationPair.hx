package com.mun.model.attribute;
import com.mun.model.attribute.OrientationValue;
import com.mun.model.attribute.OrientationAttr;
import com.mun.model.component.Component;
class OrientationPair implements Pair{
    var orientationAttr:OrientationAttr;
    var orientationValue:OrientationValue;
    public function new(na:OrientationAttr,nv:AttrValue) {
        orientationAttr=na;
        orientationValue=cast(nv,OrientationValue);
    }

    public function getAttr():Attribute{
        return orientationAttr;

    }

    public function getAttrValue():AttrValue{
        return orientationValue;
    }

    public function canupdate(c:Component,n:AttrValue):Bool{
        return true;
    }

    public function update(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            orientationValue=cast(n,OrientationValue);
            return true;
        }
        return false;

    }
}
