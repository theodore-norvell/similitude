package view.attributeView;

import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.enumeration.AttributeHexColour;
import model.selectionModel.SelectionModel;

/**
 * @author AdvaitTrivedi
 */
interface AttributeStrategyI 
{
	public function spawnHTMLAttribute(attributeUntyped: AttributeUntyped, attributeValue: AttributeValue, attributeStatus: AttributeHexColour, selectionModel: SelectionModel, view: view.View) : DivElement;
}