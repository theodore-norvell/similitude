package com.mun.controller.createComponent;

import com.mun.model.component.Component;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.enumeration.Orientation;
import com.mun.model.gates.ComponentKind;
import com.mun.view.drawComponents.DrawComponent;
//all of those imports below can not be deleted, because of using Type.resolveClass
import com.mun.model.gates.AND;
import com.mun.model.gates.FlipFlop;
import com.mun.model.gates.Input;
import com.mun.model.gates.MUX;
import com.mun.model.gates.NAND;
import com.mun.model.gates.NOR;
import com.mun.model.gates.NOT;
import com.mun.model.gates.OR;
import com.mun.model.gates.Output;
import com.mun.model.gates.XOR;

import com.mun.view.drawComponents.DrawAND;
import com.mun.view.drawComponents.DrawFlipFlop;
import com.mun.view.drawComponents.DrawInput;
import com.mun.view.drawComponents.DrawLink;
import com.mun.view.drawComponents.DrawMUX;
import com.mun.view.drawComponents.DrawNAND;
import com.mun.view.drawComponents.DrawNOR;
import com.mun.view.drawComponents.DrawNOT;
import com.mun.view.drawComponents.DrawOR;
import com.mun.view.drawComponents.DrawOutput;
import com.mun.view.drawComponents.DrawXOR;
/**
* this method can create component by using the name of the gate
* the name of the gate comes from the button id on the front page
**/
class CreateAndDraw {
    @:isVar var componentkind_(get, null):ComponentKind;
    @:isVar var component_(get, null):Component;
    var draw:DrawComponent;
    @:isVar var drawingAdapter(get, null):DrawingAdapterI;

    public function new(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:Orientation, inportNum:Int, drawingAdapter:DrawingAdapterI) {
        this.drawingAdapter = drawingAdapter;

        componentkind_ = Type.createInstance(Type.resolveClass("com.mun.model.gates." + name),[]);
        component_ = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        draw = Type.createInstance(Type.resolveClass("com.mun.view.drawComponents.Draw" + name),[component_,drawingAdapter]);
        draw.drawCorrespondingComponent();
    }

    function get_componentkind_():ComponentKind {
        return componentkind_;
    }

    function get_component_():Component {
        return component_;
    }

    function get_drawingAdapter():DrawingAdapterI {
        return drawingAdapter;
    }
}
