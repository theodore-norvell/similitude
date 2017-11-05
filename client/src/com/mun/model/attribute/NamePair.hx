package com.mun.model.attribute;
import com.mun.model.component.Component;
class NamePair implements Pair{
    var nameAttr:NameAttr;
    var nameValue:NameValue;
    public function new(na:NameAttr,nv:AttrValue) {
        nameAttr=na;
        nameValue=cast(nv,NameValue);
    }

    public function getAttr():Attribute{
        return nameAttr;

    }

    public function getAttrValue():AttrValue{
        return nameValue;
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

    public function update(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            nameValue=cast(n,NameValue);
            return true;
        }
        return false;

    }

}
