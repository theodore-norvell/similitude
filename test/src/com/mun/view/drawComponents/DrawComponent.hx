package com.mun.view.drawComponents;
interface DrawComponent {
    /**
    * draw corresponding component which means draw all of those component not only include the gate shape but also all of ports
    **/
    public function drawCorrespondingComponent(strokeColor:String):Void;
}
