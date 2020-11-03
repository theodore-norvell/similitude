package view .attributeView;
import controller.ControllerI;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import js.Browser.document;
import model.component.Component;
import model.enumeration.AttributeHexColour;
import model.observe.Observable;
import model.observe.ObservableI;
import model.observe.Observer;
import model.selectionModel.SelectionModel;
import view.View;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractAttributeStrategy {
	
	/**
	 * Wraps the elements of the attribute editor in a proper DivElement
	 * Call each time to wrap the editor for Strategy that is created
	 * @param	attributeName
	 * @param	editorDivElement
	 * @return
	 */
	public function attributeElementsWrapper(attributeName: String, editorDivElement: DivElement) : DivElement {
		var container = document.createDivElement();
		container.style.margin = "12px 10px";
		
		var label = this.createAttributeLabelElement(attributeName);
		container.appendChild(label);
		container.appendChild(editorDivElement);
		return container;
	}
	
	private function createAttributeLabelElement(attributeName: String) : DivElement {
		var label = document.createDivElement();
		label.id = "name";
		label.innerText = attributeName + " : ";
		label.style.float = "left";
		return label;
	}
}