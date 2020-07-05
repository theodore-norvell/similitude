package controller.commandManager;
import model.attribute.AttributeUntyped;
import model.attribute.AttributeValue;
import model.component.CircuitDiagramI;
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

	public function new(circuitDiagram: CircuitDiagramI, componentAffected: Component, attributeUntyped: AttributeUntyped, newAttributeValue: AttributeValue) 
	{
		this.setCircuitDiagram(circuitDiagram);
		this.componentAffected = componentAffected;
		this.newAttributeValue = newAttributeValue;
		this.attributeUntyped = attributeUntyped;
		this.oldAttributeValue = this.componentAffected.getUntyped(this.attributeUntyped);
	}
	
	override public function execute() : Void {
		if (this.componentAffected.canUpdateUntyped(this.attributeUntyped, this.oldAttributeValue)) {
			trace("changing attribute");
			this.componentAffected.updateUntyped(this.attributeUntyped, this.newAttributeValue);
		}
	}
	
	override public function redo() : Void {
		this.execute();
	}
	
	override public function undo() : Void {
		if(this.componentAffected.canUpdateUntyped(this.attributeUntyped, this.newAttributeValue)) {
			this.componentAffected.updateUntyped(this.attributeUntyped, this.oldAttributeValue);
		}
	}
}