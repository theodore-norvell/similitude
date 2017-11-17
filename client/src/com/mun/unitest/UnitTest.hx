package com.mun.unitest;
import com.mun.model.attribute.NamePair;
import com.mun.model.attribute.StringValue;
import com.mun.model.attribute.StringAttr;
import com.mun.model.attribute.OrientationPair;
import com.mun.model.attribute.OrientationValue;
import com.mun.model.attribute.OrientationAttr;
import com.mun.model.enumeration.AttrType;
import com.mun.model.component.Component;
import com.mun.model.attribute.IntValue;
import com.mun.model.attribute.IntAttr;
import com.mun.model.enumeration.ORIENTATION;
import com.mun.model.attribute.DelayPair;
class UnitTest extends haxe.unit.TestCase{
    public function new() {
        super();
    }

    public function testDelayPair(){
        var c:Component=null;
        var ia:IntAttr=new IntAttr("delay");
        var iv:IntValue=new IntValue(0);
        var dp:DelayPair=new DelayPair(ia,iv);
        assertEquals( dp.getAttrValue().getvalue()==0 );
        assertEquals( dp.canupdate(c,new IntValue(5)));
        dp.update(c,new IntValue(5));
        assertEquals( dp.getAttrValue().getvalue()==5 );
    }

    public function testIntValue(){
        var iv:IntValue=new IntValue(0);
        assertEquals( iv.getvalue()==0 );
        assertEquals( iv.getType()==AttrType.INT );
    }

    public function testIntAttr(){
        var ia:IntAttr=new IntAttr("delay");
        assertEquals( ia.getName()=="delay" );
        assertEquals(ia.getdefaultvalue().getvalue()==0);
        assertEquals(ia.getAttrType()==AttrType.INT);
    }

    public function testOrientationPair(){
        var c:Component=null;
        var ia:OrientationAttr=new OrientationAttr();
        var iv:OrientationValue=new OrientationValue(ORIENTATION.EAST);
        var dp:OrientationPair=new OrientationPair(ia,iv);
        assertEquals( dp.getAttrValue().getvalue()==ORIENTATION.EAST );
        assertEquals( dp.canupdate(c,new OrientationValue(ORIENTATION.NORTH)));
        dp.update(c,new IntValue(ORIENTATION.NORTH));
        assertEquals( dp.getAttrValue().getvalue()==ORIENTATION.NORTH );
    }

    public function testOrientationValue(){
        var iv:OrientationValue=new OrientationValue(ORIENTATION.EAST);
        assertEquals( iv.getvalue()==ORIENTATION.EAST );
        assertEquals( iv.getType()==AttrType.Orientation );
    }

    public function testOrientationAttr(){
        var ia:OrientationAttr=new OrientationAttr();
        assertEquals( ia.getName()=="orientation" );
        assertEquals(ia.getdefaultvalue().getvalue()==ORIENTATION.EAST);
        assertEquals(ia.getAttrType()==AttrType.Orientation);
    }

    public function testNamePair(){
        var c:Component=null;
        var ia:StringAttr=new StringAttr("abc");
        var iv:StringValue=new StringValue("abc");
        var dp:NamePair=new NamePair(ia,iv);
        assertEquals( dp.getAttrValue().getvalue()=="abc" );
        assertEquals( dp.canupdate(c,new OrientationValue("cd")));
        dp.update(c,new IntValue("cd"));
        assertEquals( dp.getAttrValue().getvalue()=="cd" );
    }

    public function testStringValue(){
        var iv:OrientationValue=new OrientationValue("abc");
        assertEquals( iv.getvalue()=="abc" );
        assertEquals( iv.getType()==AttrType.STRING );
    }

    public function testStringAttr(){
        var ia:StringAttr=new StringAttr("abc");
        assertEquals( ia.getName()=="abc" );
        assertEquals(ia.getdefaultvalue().getvalue()=="");
        assertEquals(ia.getAttrType()==AttrType.STRING);
    }
}
