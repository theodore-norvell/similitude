package model.observe;

import model.component.Component;
interface Observer {
    public function update(c:Component,?data:Dynamic) : Void ;
}
