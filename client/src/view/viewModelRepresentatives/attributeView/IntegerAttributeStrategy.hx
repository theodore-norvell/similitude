package view.viewModelRepresentatives.attributeView;
import controller.listenerInterfaces.CanvasListener;
import js.html.DivElement;
import js.html.InputElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.attribute.IntegerAttributeValue;
import js.Browser.document;
import model.component.Component;
import model.similitudeEvents.AttributeChangeEvent;
import view.View;

/**
 * ...
 * @author AdvaitTrivedi
 */
class IntegerAttributeStrategy extends AbstractAttributeStrategy 
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
		inputNode.type = "number";
		inputNode.id = "editor";
		inputNode.min = Std.string(Std.downcast(attributeUntyped.getDefaultValue(), IntegerAttributeValue).getValue());
		inputNode.value = Std.string(Std.downcast(attributeValue, IntegerAttributeValue).getValue());
		inputNode.oninput = function (event) {
			// trigger change to canvas as attribute is changed
			var attributeChangeEvent = new AttributeChangeEvent();
			attributeChangeEvent.attributeUntyped = attributeUntyped;
			attributeChangeEvent.newAttributeValue = new IntegerAttributeValue(Std.parseInt(event.data));
			attributeChangeEvent.componentAffected = component;
			view.handleAttributeInteractions(attributeChangeEvent);
		}
		
		editor.appendChild(inputNode);
		
		var attributeContainer = this.attributeElementsWrapper(attributeUntyped.getName(), editor);
		
		mainAttributeDivElement.appendChild(attributeContainer);
		
		return mainAttributeDivElement;
	}
}