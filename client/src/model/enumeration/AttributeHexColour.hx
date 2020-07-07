package model.enumeration;

/**
 * An abstract enum that holds HTML HEX colour codings for the attribute it is bound to.
 * @author AdvaitTrivedi
 */
@:enum
abstract AttributeHexColour(String)
{
	var VALID = "#ffffff"; // white
	var INVALID = "#fa9898"; // light grey
	var DIFFERENT = "#b8b4b4"; // light red/pink
}