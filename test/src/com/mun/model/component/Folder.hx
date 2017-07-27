package com.mun.model.component;

class Folder implements FolderI{
    var name:String;
    //use the name of circuit diagram to find the circuit diagram
    var circuitDiagramMap:Map<String, CircuitDiagramI>;
    public function new() {
        name = "Untitled";
        circuitDiagramMap = new Map<String, CircuitDiagramI>();
    }

    public function getFloderName():String{
        return name;
    }

    public function setFloderName(name:String):Void{
        this.name = name;
    }

    public function pushCircuitDiagramToMap(circuitdiagram:CircuitDiagramI):Void{
        circuitDiagramMap.set(circuitdiagram.get_name(), circuitdiagram);
    }

    public function findCircuitDiagram(name:String):CircuitDiagramI{
        return circuitDiagramMap[name];
    }

    public function removeCircuitDiagram(name:String):Void{
        circuitDiagramMap.remove(name);
    }

    public function createNewCircuitDiagram():CircuitDiagramI{
        var circuitDiagram:CircuitDiagramI = new CircuitDiagram();
        var defaultName:String = "Untitled";
        var counter:Int = 0;
        var uniqueNmaeFlag:Bool = true;
        while(true){
            for(i in circuitDiagramMap.keys()){
                defaultName = defaultName + " " + counter;
                if(i.toString() == defaultName){
                    uniqueNmaeFlag = false;
                    counter ++;
                }
            }

            if(uniqueNmaeFlag == true){
                circuitDiagram.set_name(defaultName);
                break;
            }
        }

        pushCircuitDiagramToMap(circuitDiagram);
        return circuitDiagram;
    }
}
