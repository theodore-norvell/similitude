package model.enumeration;
import model.gates.FlipFlop;
import model.component.CircuitDiagramI;
import model.gates.ComponentKind;
import model.gates.AND;
import model.gates.CompoundComponent;
import model.gates.FlipFlop ;
import model.gates.Connector ;
import model.gates.MUX ;
import model.gates.NOT;
import model.gates.OR;
import model.gates.XOR;

/**
 * This enum and Class are home to component type strings used all over the application
 * @author AdvaitTrivedi
 */
enum ComponentType 
{
	// add more cases when it comes to that
	AND;
	OR;
	XOR;
	NOT;
	// LINK; // The link has no ComponentKind class attached but will be needed in different cases
	COMPOUND_COMPONENT;
}

class ComponentTypes {
	// The link does not have a singleton object associated to it givn that it has no ComponentKind class
	
	var andComponentKind = new AND();

	var flipFlopKind = new FlipFlop() ;
	var connectorComponentKind = new Connector() ;
	var muxComponentKind = new MUX() ;
	var notComponentKind = new NOT();
	var orComponentKind = new OR();
	var xorComponentKind = new XOR();
	var compoundComponentKind: CompoundComponent;	
	public function new (circuitDiagram: CircuitDiagramI) {
		this.compoundComponentKind = new CompoundComponent(circuitDiagram);
	}
	
	public function toComponentKind (ct : ComponentType) : ComponentKind {
		return switch (ct) {
			case ComponentType.AND : this.andComponentKind;
			case ComponentType.OR : this.orComponentKind;
			case ComponentType.XOR : this.xorComponentKind;
			case ComponentType.NOT : this.notComponentKind;
			case ComponentType.COMPOUND_COMPONENT : this.compoundComponentKind;
		}
	}
}