package com.mun.model.component;

import com.mun.model.enumeration.IOTYPE;
import com.mun.model.enumeration.VALUE_LOGIC;
class Inport implements Port {

    var xPosition:Float;
    var yPosition:Float;
    var portDescription:IOTYPE;
    var value:VALUE_LOGIC;
    var sequence:Int = -1;

    public function get_xPosition():Float {
        return xPosition;
    }

    public function get_yPosition():Float {
        return yPosition;
    }

    public function set_xPosition(xPosition:Float):Void {
        this.xPosition = xPosition;
    }

    public function set_yPosition(yPosition:Float):Void {
        this.yPosition = yPosition;
    }

    public function get_value():VALUE_LOGIC {
        return value;
    }

    public function set_value(value:VALUE_LOGIC):Void {
        this.value = value;
    }

    public function get_portDescription():IOTYPE {
        return this.portDescription;
    }

    public function set_portDescription(value:IOTYPE):Void {
        this.portDescription = value;
    }

    public function get_sequence():Int {
        return this.sequence;
    }

    public function set_sequence(sequence:Int):Void {
        this.sequence = sequence;
    }

    public function new(?xPosition:Float, ?yPosition:Float) {
        this.xPosition = xPosition;
        this.yPosition = yPosition;
        portDescription = IOTYPE.INPUT;
    }

    public function createXML():Xml{
        var inportXML:Xml = Xml.createElement("Inport");

        var xPositionXML:Xml = Xml.createElement("xPosition");
        inportXML.addChild(xPositionXML);
        xPositionXML.addChild(Xml.createPCData(xPosition + ""));

        var yPositionXML:Xml = Xml.createElement("yPosition");
        inportXML.addChild(yPositionXML);
        yPositionXML.addChild(Xml.createPCData(yPosition + ""));

        var portDescriptionXML:Xml = Xml.createElement("portDescription");
        inportXML.addChild(portDescriptionXML);
        portDescriptionXML.addChild(Xml.createPCData(portDescription + ""));

        var sequenceXML:Xml = Xml.createElement("sequence");
        inportXML.addChild(sequenceXML);
        sequenceXML.addChild(Xml.createPCData(sequence + ""));

        return inportXML;
    }
}
