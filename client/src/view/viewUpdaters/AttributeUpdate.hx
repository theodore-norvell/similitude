package view.viewUpdaters;
import js.html.Element;
import model.enumeration.AttributeHexColour;
import model.observe.ObservableI;
import model.observe.Observer;
import model.selectionModel.SelectionModel;
import type.Set;
import view.View;
import view.viewModelRepresentatives.attributeView.AttributeStrategyI;
import js.html.DivElement;
import model.component.Component;
import model.attribute.*;
import view.viewModelRepresentatives.attributeView.IntegerAttributeStrategy;
import js.Browser.document;
import view.viewModelRepresentatives.attributeView.OrientationAttributeStrategy;
import view.viewModelRepresentatives.attributeView.StringAttributeStrategy;
import view.viewModelRepresentatives.attributeView.TimeAttributeStrategy;

/**
 * Used only in the Attribute update to signify the colour of the Attribute in the UI.
 * Can hold metadata about attributes.
 * 
 * The equals() method depends upon the fact that attributeUntyped are sourced from singleton ComponentKind.
 */
private class MetaAttribute {
	var attributeUntyped: AttributeUntyped = null; // unique and singleton, thus can be used in the equals() as a key
	var attributeValue: AttributeValue = null;
	var attributeStatus: AttributeHexColour;
	
	public function new(attributeUntyped: AttributeUntyped, attributeValue: AttributeValue, ?attributeStatus: AttributeHexColour = AttributeHexColour.VALID) {
		this.attributeUntyped = attributeUntyped;
		this.attributeValue = attributeValue;
		this.attributeStatus = attributeStatus;
	}
	
	public function getAttributeUntyped() : AttributeUntyped {
		return this.attributeUntyped;
	}
	
	public function getAttributeValue() : AttributeValue {
		return this.attributeValue;
	}
	
	public function getAttributeStatus() : AttributeHexColour {
		return this.attributeStatus;
	}
	
	/**
	 * sets the value of the metaAttribute to be used  further and reutnrs an Integer status code for further processing
	 * @param	metaAttribute
	 * @return
	 * 0: Attribute Exists and the value was set
	 * 1: Attribute exists and the values are the same
	 * 2: No such attribute exists 
	 */
	public function setValue(metaAttribute: MetaAttribute) : Int {
		if (this.attributeUntyped != null && metaAttribute.attributeUntyped == this.attributeUntyped)  {
			if (this.attributeValue != null && !metaAttribute.attributeValue.equals(this.attributeValue)) {
				this.attributeValue = metaAttribute.attributeValue;
				this.attributeStatus = AttributeHexColour.DIFFERENT;
				return 0;
			} else {
				return 1;
			}
		} else {
			return 2;
		} 
	}
}

/**
 * ...
 * @author AdvaitTrivedi
 */
class AttributeUpdate extends AbstractUpdate implements Observer 
{
	var attributePane: Element;
	var currentAttributeSet: Set<MetaAttribute> = new Set<MetaAttribute>();
	var componentSet: Set<Component> = null; // will change to an Array/Set when we implement it for multiple components // TODO : remove if not used
	var selectionModel: SelectionModel = null;
	
	var attributeMap: Map<AttributeType, AttributeStrategyI> = [
		IntegerAttributeValue.getTypeForClass() => new IntegerAttributeStrategy(),
		OrientationAttributeValue.getTypeForClass() => new OrientationAttributeStrategy(),
		StringAttributeValue.getTypeForClass() => new StringAttributeStrategy(),
		TimeAttributeValue.getTypeForClass() => new TimeAttributeStrategy()
	];

	public function new(view: View) 
	{
		this.setViewToUpdate(view);
		this.attributePane = document.querySelector("#attribs");
	}
	
	// TODO : remove if not used
	//private function setComponents(componentSet: Set<Component>) {
		//if (this.componentSet != componentSet) {
			//componentSet.addObserver(this);
			//if (this.componentSet != null) {
				//this.componentSet.removeObserver(this);
			//}
			//this.componentSet = componentSet;
		//}
	//}
	
	private function setSelectionModel(selectionModel: SelectionModel) {
		if (this.selectionModel != selectionModel) {
			selectionModel.addObserver(this);
			if (this.selectionModel != null) {
				this.selectionModel.removeObserver(this);
			}
			this.selectionModel = selectionModel;
		}
	}
	
	public function update(target: ObservableI, ?data:Dynamic) : Void {
		this.clearAttributes();
		buildAttributes(Std.downcast(target, SelectionModel));
		//this.notifyObservers(target, data);
	}
	
	public function buildAttributes(selectionModel: SelectionModel, ?internalUpdate: Bool = false) : Void {
		
		this.clearAttributes() ;
		
		this.setSelectionModel(selectionModel);
		
		// this collects attributes from all the components in the selectionModel
		// checks for difference in attribute values too
		var selectedComponents = this.selectionModel.getComponentSet();
		
		for (component in selectedComponents) {
			for (attribute in component.getAttributes()) {
				var correspondingValue = component.getUntyped(attribute);
				var newMetaAttribute = new MetaAttribute(attribute, correspondingValue);
				var valueHasBeenSet: Int;
				if (this.currentAttributeSet.size() == 0) {
					this.currentAttributeSet.push(newMetaAttribute);
				} else {
					for (currentMetaAttribute in this.currentAttributeSet) {
						valueHasBeenSet = currentMetaAttribute.setValue(newMetaAttribute);
						if (valueHasBeenSet < 2) {
							break;
						}
					}
					
					if (valueHasBeenSet == 2) {
						this.currentAttributeSet.push(newMetaAttribute);
					}
				}
			}
		}
				
		for (attribute in this.currentAttributeSet) {
			var strategy = this.attributeMap[attribute.getAttributeUntyped().getType()];
			if( strategy != null ) {
				this.attributePane.appendChild(strategy.spawnHTMLAttribute(attribute.getAttributeUntyped(), attribute.getAttributeValue(), attribute.getAttributeStatus(), selectionModel, this.viewToUpdate));
				this.attributePane.appendChild(document.createBRElement()); }
		}
	}
	
	public function clearAttributes() : Void {
		this.attributePane.innerHTML = "";
		this.currentAttributeSet = new Set<MetaAttribute>();
	}
}