package model.attribute;
import model.enumeration.AttrType;
interface Attribute {
    public function getdefaultvalue():AttrValue;
    public function getAttrType():AttrType;
    public function getName():String;


}
