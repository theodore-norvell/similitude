package com.mun.view.drawingImpl;
import com.mun.type.Type.Coordinate;
class ViewToWorld implements ViewToWorldI{
    var transform:Transform;

    public function new(transform:Transform) {
        this.transform = transform;
    }

    public function convertCoordinate(coordinate:Coordinate):Coordinate {
        return transform.pointConvert(coordinate);
    }

    public function get_transform():Transform {
        return transform;
    }
}
