package view.viewModelRepresentatives.attributeView;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;

/**
 * @author AdvaitTrivedi
 */
interface AttributeStrategyI 
{
	public function spawnHTMLAttribute(attributeUntyped: AttributeUntyped, attributeValue: AttributeValue, component: Component, view: view.View) : DivElement;
}