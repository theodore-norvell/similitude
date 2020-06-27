package model.attribute;

/**
 *  Objects that may be values of attributes.
 */
interface AttributeValue {
    function getType() : AttributeType ;
    function equals( other : AttributeValue ) : Bool ;
}