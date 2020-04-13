package model.observe;

interface Observer {
    public function update(target:ObservableI, ?data:Dynamic) : Void ;
}
