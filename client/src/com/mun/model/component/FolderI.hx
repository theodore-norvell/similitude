package com.mun.model.component;
import com.mun.type.Object;
interface FolderI {
    public function add(cd:CircuitDiagramI):CircuitDiagramI;

    public function getFloderName():String;

    public function setFloderName(name:String):Void;

    public function pushCircuitDiagramToMap(circuitdiagram:CircuitDiagramI):Void;

    public function findCircuitDiagram(name:String):CircuitDiagramI;

    public function removeCircuitDiagram(name:String):Void;

    public function createNewCircuitDiagram():CircuitDiagramI;

    public function changeCircuitDiagramName(oldName:String,newName:String, circuitDiagram:CircuitDiagramI):Bool;

    public function findObjectBelongsToWhichCircuitDiagram(object:Object):CircuitDiagramI;
}
