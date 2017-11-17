package com.mun.model.attribute;
import com.mun.model.attribute.IntValue;
import com.mun.model.component.Component;
class DelayPair implements Pair{
    var delayAttr:IntAttr;
    var delayValue:IntValue;
    public function new(da:IntAttr, dv:AttrValue) {
        delayAttr=da;
        delayValue=cast(dv,IntValue);
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
            delayValue=cast(n,IntValue);
            return true;
        }
        return false;

    }
}
