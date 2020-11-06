package view.attributeView;

import js.html.DivElement;
import js.html.InputElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.attribute.IntegerAttributeValue;
import js.Browser.document;
import model.component.Component;
import model.enumeration.AttributeHexColour;
import model.selectionModel.SelectionModel;
import controller.similitudeEvents.AttributeChangeEvent;
import view.View;

/**
 * ...
 * @author AdvaitTrivedi
 */
 class IntegerAttributeStrategy extends AbstractAttributeStrategy  implements AttributeStrategyI
{

	public function new() 
	{
	}
	
	public function spawnHTMLAttribute(attributeUntyped: AttributeUntyped, attributeValue : AttributeValue, attributeStatus: AttributeHexColour, selectionModel: SelectionModel, view: View) : DivElement 
	{
		var mainAttributeDivElement = document.createDivElement();
		mainAttributeDivElement.id = attributeUntyped.getName() + "_attrib"; 
		mainAttributeDivElement.style.height = "10%";
		mainAttributeDivElement.style.width = "100%";
		mainAttributeDivElement.style.display = "inline-block"; 
		mainAttributeDivElement.style.backgroundColor = Std.string(attributeStatus); // an enum abstract with an underlying class (String) should return as a string at runtime, so ideally the Std.string() is useless, but it won't compile without it.
		
		var editor = document.createDivElement();
		editor.style.float = "left";
		editor.style.marginLeft = "5px";
		
		var inputNode = document.createInputElement();
		inputNode.type = "number";
		inputNode.id = "editor";
		inputNode.min = Std.string(Std.downcast(attributeUntyped.getDefaultValue(), IntegerAttributeValue).getValue());
		inputNode.value = Std.string(Std.downcast(attributeValue, IntegerAttributeValue).getValue());
		inputNode.oninput = function (event) {
			// trigger change to canvas as attribute is changed
			var newAttributeValue = new IntegerAttributeValue(Std.parseInt(event.data));
			var attributeChangeEvent = new AttributeChangeEvent(attributeUntyped,newAttributeValue, selectionModel );
			view.changeAttributeValue(attributeChangeEvent);
		}
		
		editor.appendChild(inputNode);
		
		var attributeContainer = this.attributeElementsWrapper(attributeUntyped.getName(), editor);
		
		mainAttributeDivElement.appendChild(attributeContainer);
		
		return mainAttributeDivElement;
	}
}