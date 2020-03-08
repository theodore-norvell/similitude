package model.attribute;
import model.enumeration.AttrType;
interface AttrValue {
    public function getvalue():Dynamic;
    public function getType():AttrType;
}
