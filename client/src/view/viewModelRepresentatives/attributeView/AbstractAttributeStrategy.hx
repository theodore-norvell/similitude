package view.viewModelRepresentatives.attributeView;
import controller.listenerInterfaces.CanvasListener;
import js.html.DivElement;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import js.Browser.document;
import model.component.Component;
import model.observe.Observable;
import model.observe.ObservableI;
import model.observe.Observer;
import view.View;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AbstractAttributeStrategy  implements AttributeStrategyI
{
	var canvasListener: CanvasListener;
	var attributeUntyped: AttributeUntyped;
	
	/* INTERFACE view.viewModelRepresentatives.attributeView.AttributeStrategy */
	/**
	 * COMPULSORILY OVERRIDE in child classes
	 * @return
	 */
	public function spawnHTMLAttribute(attributeUntyped: AttributeUntyped, attributeValue : AttributeValue, component: Component, view: View):DivElement 
	{
		return new DivElement();
	}
	
	/**
	 * Wraps the elements of the attribute editor in a proper DivElement
	 * Call each time to wrap the editor for Strategy that is created
	 * @param	attributeName
	 * @param	editorDivElement
	 * @return
	 */
	public function attributeElementsWrapper(attributeName: String, editorDivElement: DivElement) : DivElement {
		var container = document.createDivElement();
		container.style.margin = "10px 10px 0px 10px";
		
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