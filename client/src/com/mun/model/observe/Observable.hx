package com.mun.model.observe;
class Observable {

    var Observers:Observer= new Observer();

    public function new(OB:Observer) {
        Observers = OB;
    }


    public function addObserver(obs:Observer):Bool {
        if (obs == null) {
            return false;
        }

        // search for replica
        if(Observers==null){
            return false;
        }

        return true;
    }


    public function removeObserver(obs:Observer):Bool {
        return Observers=null;
    }


    public function notifyObservers(?data:Dynamic):Void {

        Observer.update(this,data);
    }

}
