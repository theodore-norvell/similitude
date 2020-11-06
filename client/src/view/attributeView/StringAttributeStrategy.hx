package view.attributeView;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;
import js.Browser.document;
import model.attribute.StringAttributeValue;
import model.enumeration.AttributeHexColour;
import model.selectionModel.SelectionModel;
import controller.similitudeEvents.AttributeChangeEvent;

/**
 * ...
 * @author AdvaitTrivedi
 */
 class StringAttributeStrategy extends AbstractAttributeStrategy  implements AttributeStrategyI
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
		mainAttributeDivElement.style.backgroundColor = Std.string(attributeStatus);
		
		var editor = document.createDivElement();
		editor.style.float = "left";
		editor.style.marginLeft = "5px";
		
		var inputNode = document.createInputElement();
		inputNode.type = "text";
		inputNode.id = "editor";
		inputNode.value = Std.downcast(attributeValue, StringAttributeValue).getValue();
		inputNode.onchange = function (event) {
			// trigger change to canvas as attribute is changed
			 var newAttributeValue = new StringAttributeValue(inputNode.value);
			var attributeChangeEvent = new AttributeChangeEvent(attributeUntyped, newAttributeValue, selectionModel);
			view.changeAttributeValue(attributeChangeEvent);
		}
		
		editor.appendChild(inputNode);
		
		var attributeContainer = this.attributeElementsWrapper(attributeUntyped.getName(), editor);
		
		mainAttributeDivElement.appendChild(attributeContainer);
		
		return mainAttributeDivElement;
	}
}