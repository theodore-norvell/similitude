package model.enumeration;
import model.gates.FlipFlop;
import model.component.CircuitDiagramI;
import model.gates.ComponentKind;
import model.gates.AND;
import model.gates.CompoundComponent;
import model.gates.FlipFlop ;
import model.gates.Input ;
import model.gates.MUX ;
import model.gates.NAND;
import model.gates.NOR;
import model.gates.NOT;
import model.gates.OR;
import model.gates.Output;
import model.gates.XOR;

/**
 * This enum and Class are home to component type strings used all over the application
 * @author AdvaitTrivedi
 */
enum ComponentType 
{
	// add more cases when it comes to that
	AND;
	NAND;
	OR;
	NOR;
	XOR;
	NOT;
	COMPOUND_COMPONENT;
}

class ComponentTypes {
	var andComponentKind = new AND();

	var flipFlopKind = new FlipFlop() ;
	var inputComponentKind = new Input() ;
	var muxComponentKind = new MUX() ;
	var nandComponentKind = new NAND();
	var norComponentKind = new NOR();
	var notComponentKind = new NOT();
	var orComponentKind = new OR();
	var outputComponentKind = new Output();
	var xorComponentKind = new XOR();
	var compoundComponentKind: CompoundComponent;
	
	public function new (circuitDiagram: CircuitDiagramI) {
		this.compoundComponentKind = new CompoundComponent(circuitDiagram);
	}
	
	public function toComponentKind (ct : ComponentType) : ComponentKind {
		return switch (ct) {
			case ComponentType.AND : this.andComponentKind;
			case ComponentType.NAND : this.nandComponentKind;
			case ComponentType.OR : this.orComponentKind;
			case ComponentType.NOR : this.norComponentKind;
			case ComponentType.XOR : this.xorComponentKind;
			case ComponentType.NOT : this.notComponentKind;
			case ComponentType.COMPOUND_COMPONENT : this.compoundComponentKind;
		}
	}
}