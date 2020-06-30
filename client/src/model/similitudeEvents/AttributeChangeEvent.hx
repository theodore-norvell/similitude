package model.similitudeEvents;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AttributeChangeEvent extends AbstractSimilitudeEvent 
{
	public var attributeUntyped: AttributeUntyped;
	public var newAttributeValue : AttributeValue;
	public var componentAffected: Component;
	
	public function new() {
		this.eventTypes = EventTypesEnum.ATTRIBUTE_CHANGED;
	}
}