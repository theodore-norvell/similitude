package com.mun.controller.componentUpdate;

import com.mun.type.Type.Object;
import com.mun.controller.command.Command;
import com.mun.controller.command.AddCommand;
import com.mun.controller.command.CommandManager;
import com.mun.model.gates.ComponentKind;
import com.mun.model.enumeration.Orientation;
import com.mun.model.drawingInterface.DrawingAdapterI;
import com.mun.model.component.CircuitDiagram;
import com.mun.model.component.Component;

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
//the above imports shouldn't be deleted

class UpdateCircuitDiagram {
    var circuitDiagram:CircuitDiagram;
    var updateCanvas:UpdateCanvas;
    var commandManager:CommandManager;

    public function new(circuitDiagram:CircuitDiagram,updateCanvas:UpdateCanvas) {
        this.circuitDiagram = circuitDiagram;
        this.updateCanvas = updateCanvas;

        commandManager = new CommandManager(circuitDiagram);
    }

    public function createComponentByButton(name:String, xPosition:Float, yPosition:Float, width:Float, height:Float, orientation:Orientation, inportNum:Int, drawingAdapter:DrawingAdapterI){
        var componentkind_:ComponentKind = Type.createInstance(Type.resolveClass("com.mun.model.gates." + name),[]);
        var component_:Component = new Component(xPosition, yPosition, height, width, orientation, componentkind_, inportNum);
        component_.setNameOfTheComponentKind(name);

        var object:Object = {"link":null,"component":component_,"endPoint":null};
        trace(object);
        var command:Command = new AddCommand(object,circuitDiagram);
        command.execute();
        redrawCanvas();
    }

    function redrawCanvas(){
        updateCanvas.update();
    }
}
