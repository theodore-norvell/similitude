package com.mun.model.attribute;
import com.mun.model.component.Component;
class DelayPair implements Pair{
    var DelayAttr:DelayAttr;
    var DelayValue:DelayValue;
    public function new(da:DelayAttr,dv:DelayValue) {
        DelayAttr=da;
        DelayValue=dv;
    }

    public function getAttr():Attribute{
        return DelayAttr;

    }

    public function getAttrValue():AttrValue{
        return DelayValue;
    }

    public function canupdate(c:Component,n:AttrValue):Bool{
        if(!Std.is(n,DelayValue)){
            return false;
        }
        if(n.getvalue()<0||n.getvalue()==null){
            return false;
        }
        else return true;
    }

    // change to void
    public function putAttr(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            DelayValue=n;
            return true;
        }
        return false;

    }
}
