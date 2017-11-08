package com.mun.model.attribute;
import com.mun.model.attribute.DelayValue;
import com.mun.model.component.Component;
class DelayPair implements Pair{
    var delayAttr:DelayAttr;
    var delayValue:DelayValue;
    public function new(da:DelayAttr,dv:AttrValue) {
        delayAttr=da;
        delayValue=cast(dv,DelayValue);
    }

    public function getAttr():Attribute{
        return delayAttr;

    }

    public function getAttrValue():AttrValue{
        return delayValue;
    }

    public function canupdate(c:Component,n:AttrValue):Bool{
        if(!Std.is(n,delayValue)){
            return false;
        }
        if(n.getvalue()<0||n.getvalue()==null){
            return false;
        }
        else return true;
    }

    // change to void
    public function update(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            delayValue=cast(n,DelayValue);
            return true;
        }
        return false;

    }
}
