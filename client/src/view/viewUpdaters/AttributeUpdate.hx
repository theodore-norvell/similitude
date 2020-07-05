package view.viewUpdaters;
import js.html.Element;
import model.observe.ObservableI;
import model.observe.Observer;
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
 * ...
 * @author AdvaitTrivedi
 */
class AttributeUpdate extends AbstractUpdate implements Observer 
{
	var attributePane: Element;
	var currentAttributeList: Iterator<AttributeUntyped>;
	var component: Component = null; // will change to an Array/Set when we implement it for multiple components
	
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
	
	public function setComponent(component: Component) {
		if (this.component != component) {
			component.addObserver(this);
			if (this.component != null) {
				this.component.removeObserver(this);
			}
			this.component = component;
		}
	}
	
	public function update(target: ObservableI, ?data:Dynamic) : Void {
		this.clearAttributes();
		buildAttributes(Std.downcast(target, Component));
		//this.notifyObservers(target, data);
	}
	
	public function buildAttributes(component: Component) : Void {
		this.setComponent(component);
		for (attribute in component.getAttributes()) {
			var strategy = this.attributeMap[attribute.getType()];
			if( strategy != null ) {
				this.attributePane.appendChild(strategy.spawnHTMLAttribute(attribute, component.getUntyped(attribute), component, this.viewToUpdate));
				this.attributePane.appendChild(document.createBRElement()); }
		}
	}
	
	public function clearAttributes() : Void {
		this.attributePane.innerHTML = "";
	}
}