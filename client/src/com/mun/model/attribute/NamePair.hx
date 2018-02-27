package com.mun.model.attribute;
import com.mun.model.component.Component;
class NamePair implements Pair{
    var nameAttr:StringAttr;
    var nameValue:StringValue;
    public function new(na:StringAttr, nv:AttrValue) {
        nameAttr=na;
        nameValue=cast(nv,StringValue);
    }

    public function getAttr():Attribute{
        return nameAttr;

    }

    public function getAttrValue():AttrValue{
        return nameValue;
    }

    public function canupdate(c:Component,n:AttrValue):Bool{
        /*if(!Std.is(n,StringValue)){
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
        else return true;*/
        return true;
    }

    public function update(c:Component,n:AttrValue):Bool{
        if(canupdate(c,n)==true){
            nameValue=cast(n,StringValue);
            return true;
        }
        return false;

    }

}
