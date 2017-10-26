package com.mun.model.attribute;
import com.mun.model.component.Component;
class NamePair {
    var NameAttr:NameAttr;
    var NameValue:NameValue;
    public function new(na:NameAttr,nv:NameValue) {
        NameAttr=na;
        NameValue=nv;
    }

    public function getAttr():Attribute{
        return NameAttr;

    }

    public function getAttrValue():AttrValue{
        return NameValue;
    }

    public function canupdate(c:Component,n:AttrValue):Bool{
        if(!Std.is(n,NameValue)){
            return false;
        }
        var b:Bool=true;
        for(i in c.get_CircuitDiagram().get_componentIterator()){
            if(i.get_name()==n.getvalue()){
                b=false;
            }
        }
        if(b==false){
            return false;
        }
        else return true;
    }

    public function putAttr(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            DelayValue=n;
            return true;
        }
        return false;

    }

}
