package model.attribute;

/**
 *  Attributes are used as keys to get attribute values.
 * All attributes will implement this interface.
 */
interface AttributeUntyped {
    /**Get an object representing the type of the attribute.
    * Type objects should be singletons so they can be compared by 
    * @return AttributeType 
    */
    public function getType() : AttributeType ;

    public function getDefaultValue() : AttributeValue ;

    public function getName() : String ;
}