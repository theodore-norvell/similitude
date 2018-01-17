package js.npm;

import js.support.Callback;

typedef GlobOptions = {
	?cwd : String,
	?root : String,
	?dot : Bool,
	?nomount : Bool,
	?mark : Bool,
	?nosort : Bool,
	?stat : Bool,
	?silent : Bool,
	?strict : Bool,
	?cache : Dynamic,
	?statCache : Dynamic,
	?symlinks : Dynamic,
	?nounique : Bool,
	?nonull : Bool,
	?debug : Bool,
	?nobrace : Bool,
	?noglobstar : Bool,
	?noext : Bool,
	?nocase : Bool,
	?matchBase : Bool,
	?nodir : Bool,
	?ignore : Dynamic,
	?follow : Bool,
	?realpath : Bool
}

extern class Glob
implements npm.Package.Require<"glob", "^5.0.10">
{
	@:overload(function(pattern : String) : Bool {})
	public static function hasMagic(pattern : String, options : {?noext: Bool, ?nobrace: Bool}) : Bool;

	@:overload(function(pattern : String, options : Glob) : Array<String> {})
	@:overload(function(pattern : String, options : GlobOptions) : Array<String> {})
	public static function sync(pattern : String) : Array<String>;

	@:overload(function(pattern : String, options : Glob, cb : Callback1<Array<String>>) : Void {})
	@:overload(function(pattern : String, options : GlobOptions, cb : Callback1<Array<String>>) : Void {})
	public function new(pattern : String, cb : Callback1<Array<String>>) : Void;
}
