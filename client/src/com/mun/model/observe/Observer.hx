package com.mun.model.observe;
import com.mun.model.observe.Observable;
class Observer {

    var Observables:Array<Observable> = new Array<Observable>();

    public function new() {
    }

    public function addObserverable(obs:Observable):Bool{
        if (obs == null) {
            return false;
        }

        for (o in Observables) {
            if (o == obs) return false;
        }

        Observables.push(obs);

        return true;
    }

    public function removeObserable(obs:Observable):Bool {
        return Observables.remove(obs);
    }

    public function removeObservers():Void {
        return Observables=[];
    }

    public function countObservers():Int {
        return Observables.length;
    }

    public function update():Void{

    }
}
