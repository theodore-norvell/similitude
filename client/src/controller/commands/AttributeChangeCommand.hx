package controller.commands ;

import commandManager.CommandI ;
import assertions.Assert ;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.Component;

/**
 * ...
 * @author AdvaitTrivedi
 */
class AttributeChangeCommand extends AbstractCommand 
{
	var componentAffected: Component;
	var attributeUntyped: AttributeUntyped;
	var oldAttributeValue: AttributeValue;
	var newAttributeValue: AttributeValue;

	public function new(component : Component, attribute : AttributeUntyped, newValue : AttributeValue) 
	{
		this.setCircuitDiagram(component.get_CircuitDiagram() );
		this.componentAffected = component;
		this.newAttributeValue = newValue;
		this.attributeUntyped = attribute;
		this.oldAttributeValue = this.componentAffected.getUntyped(this.attributeUntyped);
	}
	
	override public function execute() : Void {
		Assert.assert( this.componentAffected.canUpdateUntyped(this.attributeUntyped, this.newAttributeValue)) ;
		trace("changing attribute");
		this.componentAffected.updateUntyped(this.attributeUntyped, this.newAttributeValue);
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		Assert.assert( this.componentAffected.canUpdateUntyped(this.attributeUntyped, this.oldAttributeValue)) ;
		this.componentAffected.updateUntyped(this.attributeUntyped, this.oldAttributeValue);
	}
}