package model.similitudeEvents;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;
import model.selectionModel.SelectionModel;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AttributeChangeEvent extends AbstractSimilitudeEvent 
{
	public var attributeUntyped: AttributeUntyped;
	public var newAttributeValue : AttributeValue;
	public var selectionAffected: SelectionModel;
	
	public function new() {
		this.eventTypes = EventTypesEnum.ATTRIBUTE_CHANGED;
	}
}