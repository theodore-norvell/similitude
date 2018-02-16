package com.mun.model.component;

import com.mun.type.Object;
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

    //precondiction: the IntAttr name should not blank && is not equal to ""
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

    /**
    * precondiction: The component or link or endpoint or port should belong to one exist circuit diagram
    **/
    public function findObjectBelongsToWhichCircuitDiagram(object:Object):CircuitDiagramI{
        for(i in circuitDiagramMap.iterator()){
            if(object.get_component() != null){
                for(j in i.get_componentIterator()){
                    if(j == object.get_component()){
                        return i;
                    }

                    if(object.get_port() != null){
                        for(k in j.get_inportIterator()){
                            if(object.get_port() == k){
                                return i;
                            }
                        }

                        for(k in j.get_outportIterator()){
                            if(object.get_port() == k){
                                return i;
                            }
                        }
                    }
                }
            }

            if(object.get_link() != null || object.get_endPoint() != null){
                for(j in i.get_linkIterator()){
                    if(object.get_link() != null && object.get_link() == j){
                        return i;
                    }

                    if(object.get_endPoint() != null){
                        if(object.get_endPoint() == j.get_rightEndpoint() || object.get_endPoint() == j.get_leftEndpoint()){
                            return i;
                        }
                    }
                }
            }
        }

        return null;//this line should never happen
    }
}
