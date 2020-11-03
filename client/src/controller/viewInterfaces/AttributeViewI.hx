package controller.viewInterfaces ;

import model.selectionModel.SelectionModel ;

interface AttributeViewI {
    public function clearAttributes() : Void ;
    public function buildAttributes( selectionModel : SelectionModel, refresh : Bool ) : Void ;
}