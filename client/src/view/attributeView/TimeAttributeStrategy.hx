package view.attributeView;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.attribute.TimeAttributeValue;
import model.component.Component;
import js.Browser.document;
import model.enumeration.AttributeHexColour;
import model.selectionModel.SelectionModel;
import model.similitudeEvents.AttributeChangeEvent;
import type.TimeUnit ;
import model.attribute.StringAttributeValue;
import haxe.Int64;

/**
 * ...
 * @author AdvaitTrivedi
 */
class TimeAttributeStrategy extends AbstractAttributeStrategy  implements AttributeStrategyI
{

	public function new() 
	{
		
	}
	
	public function spawnHTMLAttribute(attributeUntyped: AttributeUntyped, attributeValue : AttributeValue, attributeStatus: AttributeHexColour, selectionModel: SelectionModel, view: View) : DivElement 
	{
		var timeAttribute = Std.downcast(attributeValue, TimeAttributeValue);
		
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
		inputNode.value = Std.string(timeAttribute.getValueIn(timeAttribute.getUnit()));
		
		var unitDropDown = document.createSelectElement();
		unitDropDown.id = "editor";
		
		var femtoSecondOption = document.createOptionElement();
		femtoSecondOption.text = "FEMPTO_SECOND";
		
		var picoSecondOption = document.createOptionElement();
		picoSecondOption.text = "PICO_SECOND";
		
		var nanoSecondOption = document.createOptionElement();
		nanoSecondOption.text = "NANO_SECOND";
		
		var microSecondOption = document.createOptionElement();
		microSecondOption.text = "MICRO_SECOND";
		
		var miliSecondOption = document.createOptionElement();
		miliSecondOption.text = "MILI_SECOND";
		
		var secondOption = document.createOptionElement();
		secondOption.text = "SECOND";
		
		unitDropDown.add(femtoSecondOption);
		unitDropDown.add(picoSecondOption);
		unitDropDown.add(nanoSecondOption);
		unitDropDown.add(microSecondOption);
		unitDropDown.add(miliSecondOption);
		unitDropDown.add(secondOption);
		
		unitDropDown.value = Std.string(Std.downcast(attributeValue, TimeAttributeValue).getUnit());
		
		unitDropDown.onchange = function (event) {
			// trigger change to canvas as attribute is changed
			var attributeChangeEvent = new AttributeChangeEvent();
			attributeChangeEvent.attributeUntyped = attributeUntyped;
			attributeChangeEvent.newAttributeValue = new TimeAttributeValue(Int64.parseString(inputNode.value), Type.createEnum(TimeUnit, unitDropDown.value));
			attributeChangeEvent.selectionAffected = selectionModel;
			view.changeAttributeValue(attributeChangeEvent);
		}
		
		unitDropDown.style.marginLeft = "3px";
		
		inputNode.onchange = function (event) {
			// trigger change to canvas as attribute is changed
			var attributeChangeEvent = new AttributeChangeEvent();
			attributeChangeEvent.attributeUntyped = attributeUntyped;
			attributeChangeEvent.newAttributeValue = new TimeAttributeValue(Int64.parseString(inputNode.value), Type.createEnum(TimeUnit, unitDropDown.value));
			attributeChangeEvent.selectionAffected = selectionModel;
			view.changeAttributeValue(attributeChangeEvent);
		}
		
		editor.appendChild(inputNode);
		editor.appendChild(unitDropDown);
		
		var attributeContainer = this.attributeElementsWrapper(attributeUntyped.getName(), editor);
		
		mainAttributeDivElement.appendChild(attributeContainer);
		
		return mainAttributeDivElement;
	}
}