package com.mun.model.observe;
import com.mun.model.component.Component;
import Array;
class Observable {

    var observers:Array<Observer>= new Array<Observer>();

    public function new() {

    }


    public function addObserver(obs:Observer):Bool {
        if(obs==null){
            return false;
        }
        else {
            observers.push(obs);
            return true;
        }
    }


    public function removeObserver(obs:Observer):Bool {
        return observers.remove(obs);
    }


    public function notifyObservers(c:Component,?data:Dynamic):Void {
        for(n in observers){
            n.update(c,data);
        }
    }

}
