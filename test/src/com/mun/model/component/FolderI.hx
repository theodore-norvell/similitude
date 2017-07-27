package com.mun.model.component;
interface FolderI {
    public function getFloderName():String;

    public function setFloderName(name:String):Void;

    public function pushCircuitDiagramToMap(circuitdiagram:CircuitDiagramI):Void;

    public function findCircuitDiagram(name:String):CircuitDiagramI;

    public function removeCircuitDiagram(name:String):Void;

    public function createNewCircuitDiagram():CircuitDiagramI;
}
