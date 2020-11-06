package controller.similitudeEvents;
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
	public var attributeUntyped(default, null): AttributeUntyped;
	public var newAttributeValue(default, null) : AttributeValue;
	public var selectionAffected(default, null): SelectionModel;
	
	public function new( attributeUntyped: AttributeUntyped,
						 newAttributeValue: AttributeValue,
						 selectionAffected: SelectionModel) {
		super( EventTypesEnum.ATTRIBUTE_CHANGED ) ;
		this.attributeUntyped = attributeUntyped ;
		this.newAttributeValue = newAttributeValue ;
		this.selectionAffected = selectionAffected ;
	}
}