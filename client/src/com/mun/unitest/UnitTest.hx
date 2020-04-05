package com.mun.unitest;
import com.mun.model.gates.AND;
import com.mun.model.component.CircuitDiagram;
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
        assertTrue( dp.getAttrValue().getvalue()==0 );
        assertTrue( dp.canupdate(c,new IntValue(5)));
        dp.update(c,new IntValue(5));
        assertTrue( dp.getAttrValue().getvalue()==5 );
    }

    public function testIntValue(){
        var iv:IntValue=new IntValue(0);
        assertTrue( iv.getvalue()==0 );
        assertTrue( iv.getType()==AttrType.INT);
    }

    public function testIntAttr(){
        var ia:IntAttr=new IntAttr("delay");
        assertTrue( ia.getName()=="delay" );
        assertTrue(ia.getdefaultvalue().getvalue()==0);
        assertTrue(ia.getAttrType()==AttrType.INT);
    }

    public function testOrientationPair(){
        var c:Component=null;
        var ia:OrientationAttr=new OrientationAttr();
        var iv:OrientationValue=new OrientationValue(ORIENTATION.EAST);
        var dp:OrientationPair=new OrientationPair(ia,iv);
        assertTrue( dp.getAttrValue().getvalue()==ORIENTATION.EAST );
        assertTrue( dp.canupdate(c,new OrientationValue(ORIENTATION.NORTH)));
        dp.update(c,new OrientationValue(ORIENTATION.NORTH));
        assertTrue( dp.getAttrValue().getvalue()==ORIENTATION.NORTH );
    }

    public function testOrientationValue(){
        var iv:OrientationValue=new OrientationValue(ORIENTATION.EAST);
        assertTrue( iv.getvalue()==ORIENTATION.EAST );
        assertTrue( iv.getType()==AttrType.Orientation );
    }

    public function testOrientationAttr(){
        var ia:OrientationAttr=new OrientationAttr();
        assertTrue( ia.getName()=="orientation" );
        assertTrue(ia.getdefaultvalue().getvalue()==ORIENTATION.EAST);
        assertTrue(ia.getAttrType()==AttrType.Orientation);
    }

    public function testNamePair(){
        var c:Component=null;
        var ia:StringAttr=new StringAttr("abc");
        var iv:StringValue=new StringValue("abc");
        var dp:NamePair=new NamePair(ia,iv);
        assertTrue( dp.getAttrValue().getvalue()=="abc" );
        assertTrue( dp.canupdate(c,new StringValue("cd")));
        dp.update(c,new StringValue("cd"));
        assertTrue( dp.getAttrValue().getvalue()=="cd" );
    }

    public function testStringValue(){
        var iv:StringValue=new StringValue("abc");
        assertTrue( iv.getvalue()=="abc" );
        assertTrue( iv.getType()==AttrType.STRING );
    }

    public function testStringAttr(){
        var ia:StringAttr=new StringAttr("abc");
        assertTrue( ia.getName()=="abc" );
        assertTrue(ia.getdefaultvalue().getvalue()=="");
        assertTrue(ia.getAttrType()==AttrType.STRING);
    }

    public function testObserver(){
        var cd:CircuitDiagram=new CircuitDiagram();
        var c:Component=new Component(1,1,1,1,ORIENTATION.EAST,new AND(),2);
        cd.addComponent(c);
        assertTrue(c.removeObserver(cd));
    }
}
