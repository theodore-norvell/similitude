package model.observe ;

interface ObservableI {

    public function addObserver(obs:Observer) : Void ;


    public function removeObserver(obs:Observer):Void ;


    public function notifyObservers(target:ObservableI,?data:Dynamic):Void ;

}
