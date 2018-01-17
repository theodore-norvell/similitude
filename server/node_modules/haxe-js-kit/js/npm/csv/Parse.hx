package js.npm.csv;

import js.Error;
import js.node.stream.Transform;

typedef ParseOptions = {
	?delimiter : String,
	?rowDelimiter : String,
	?quote : String,
	?escape : String,
	?columns : Dynamic,
	?comment : String,
	?objname : String,
	?relax : Bool,
	?skip_empty_lines : Bool,
	?trim : Bool,
	?ltrim : Bool,
	?rtrim : Bool,
	?auto_parse : Bool
}

extern class Parse
extends Transform
implements npm.Package.Require<"csv-parse", "^0.1.0">
{
	@:overload(function() : Void {})
	@:overload(function(options : ParseOptions) : Void {})
	@:overload(function(input : String, callback : Error -> Array<Array<String>> -> Void) : Void {})
	public function new(input : String, options : ParseOptions, callback : Error -> Array<Array<String>> -> Void) : Void;

	public var count(default, null) : Int;
	public var lines(default, null) : Int;

	public var regexp_int(default, default) : EReg;
	public var regexp_float(default, default) : EReg;
}
