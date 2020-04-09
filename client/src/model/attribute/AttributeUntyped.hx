package model.attribute;

/**
 *  Attributes are used as keys to get attribute values.
 * All attributes will implement this interface.
 * Only the parameterized class Attribute should implement this type.
 * Therefore this type is equivalent to the existential type
 *    (exists T <: AttributeValue. Attribute<T>) ;
 * in other words, for all objects o,
 *        o : AttributeUntyped
 *    iff there exists a type T that extends AttributeValue
 *           and o : Attribute<T>
 */
interface AttributeUntyped {
    /** Get an object representing the type of the attribute.
    * Type objects should be singletons so they can be compared by equality.
    * @return AttributeType 
    */
    public function getType() : AttributeType ;

    public function getDefaultValue() : AttributeValue ;

    public function getName() : String ;
}