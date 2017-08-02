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
        var autoGenerateName:String = "";
        var counter:Int = 0;
        var uniqueNmaeFlag:Bool = true;
        while(true){
            autoGenerateName = "Untitled " + counter;
            for(i in circuitDiagramMap.keys()){
                if(i.toString() == autoGenerateName){
                    uniqueNmaeFlag = false;
                    break;
                }
            }

            if(uniqueNmaeFlag == true){
                circuitDiagram.set_name(autoGenerateName);
                break;
            }
            counter ++;
            uniqueNmaeFlag = true;
        }

        pushCircuitDiagramToMap(circuitDiagram);
        return circuitDiagram;
    }

    //precondiction: the new name should not blank && is not equal to ""
    public function changeCircuitDiagramName(oldName:String,newName:String, circuitDiagram:CircuitDiagramI):Bool{
        if(circuitDiagramMap.exists(newName)){
            return false;
        }else{
            circuitDiagram.set_name(newName);
            circuitDiagramMap.remove(oldName);
            circuitDiagramMap.set(newName, circuitDiagram);
            return true;
        }
    }

    public function deleteCircuitDiagram(name:String){
        circuitDiagramMap.remove(name);
    }
}
