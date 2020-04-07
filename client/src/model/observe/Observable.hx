package model.observe ;
import assertions.Assert;

class Observable {

    var observers:Array<Observer>= new Array<Observer>();

    //public function new() {
//
    //}


    public function addObserver(obs:Observer) : Void {
        Assert.assert( obs != null ) ;
        if( observers.indexOf( obs ) == -1 ) observers.push(obs);
    }


    public function removeObserver(obs:Observer):Void {
        Assert.assert( obs != null ) ;
        observers.remove(obs);
    }


    public function notifyObservers(target:Any,?data:Dynamic):Void {
        for(n in observers) {
            n.update( target, data);
        }
    }

}
