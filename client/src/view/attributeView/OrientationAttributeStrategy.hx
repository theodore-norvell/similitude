package view.attributeView;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;
import js.Browser.document;
import model.enumeration.AttributeHexColour;
import model.selectionModel.SelectionModel;
import model.similitudeEvents.AttributeChangeEvent;
import model.attribute.OrientationAttributeValue;
import model.enumeration.Orientation;

/**
 * ...
 * @author AdvaitTrivedi
 */
 class OrientationAttributeStrategy extends AbstractAttributeStrategy  implements AttributeStrategyI
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
		
		var orientationDropDown = document.createSelectElement();
		orientationDropDown.id = "editor";
		
		var eastOrientation = document.createOptionElement();
		eastOrientation.text = "EAST";
		
		var westOrientation = document.createOptionElement();
		westOrientation.text = "WEST";
		
		var northOrientation = document.createOptionElement();
		northOrientation.text = "NORTH";
		
		var southOrientation = document.createOptionElement();
		southOrientation.text = "SOUTH";
		
		orientationDropDown.add(eastOrientation);
		orientationDropDown.add(westOrientation);
		orientationDropDown.add(northOrientation);
		orientationDropDown.add(southOrientation);
		
		orientationDropDown.value = Std.string(Std.downcast(attributeValue, OrientationAttributeValue).getOrientation());
		
		orientationDropDown.onchange = function (event) {
			// trigger change to canvas as attribute is changed
			var attributeChangeEvent = new AttributeChangeEvent();
			attributeChangeEvent.attributeUntyped = attributeUntyped;
			attributeChangeEvent.newAttributeValue = new OrientationAttributeValue(Type.createEnum(Orientation, orientationDropDown.value));
			attributeChangeEvent.selectionAffected = selectionModel;
			view.handleAttributeInteractions(attributeChangeEvent);
		}
		
		editor.appendChild(orientationDropDown);
		
		var attributeContainer = this.attributeElementsWrapper(attributeUntyped.getName(), editor);
		
		mainAttributeDivElement.appendChild(attributeContainer);
		
		return mainAttributeDivElement;
	}
	
}