package view.viewModelRepresentatives.attributeView;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;
import js.Browser.document;
import model.attribute.StringAttributeValue;
import model.similitudeEvents.AttributeChangeEvent;

/**
 * ...
 * @author AdvaitTrivedi
 */
class StringAttributeStrategy extends AbstractAttributeStrategy 
{

	public function new() 
	{
		
	}
	
	override public function spawnHTMLAttribute(attributeUntyped: AttributeUntyped, attributeValue : AttributeValue, component: Component, view: View) : DivElement 
	{
		var mainAttributeDivElement = document.createDivElement();
		mainAttributeDivElement.id = attributeUntyped.getName() + "_attrib"; 
		mainAttributeDivElement.style.height = "10%";
		
		var editor = document.createDivElement();
		editor.style.float = "left";
		editor.style.marginLeft = "5px";
		
		var inputNode = document.createInputElement();
		inputNode.type = "text";
		inputNode.id = "editor";
		inputNode.value = Std.downcast(attributeValue, StringAttributeValue).getValue();
		inputNode.onchange = function (event) {
			// trigger change to canvas as attribute is changed
			var attributeChangeEvent = new AttributeChangeEvent();
			attributeChangeEvent.attributeUntyped = attributeUntyped;
			attributeChangeEvent.newAttributeValue = new StringAttributeValue(inputNode.value);
			attributeChangeEvent.componentAffected = component;
			view.handleAttributeInteractions(attributeChangeEvent);
		}
		
		editor.appendChild(inputNode);
		
		var attributeContainer = this.attributeElementsWrapper(attributeUntyped.getName(), editor);
		
		mainAttributeDivElement.appendChild(attributeContainer);
		
		return mainAttributeDivElement;
	}
}