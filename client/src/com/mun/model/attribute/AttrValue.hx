package com.mun.model.attribute;
import sys.db.Object;
import com.mun.model.enumeration.AttrType;
interface AttrValue {
    public function getvalue():Object;
    public function getType():AttrType;
}
