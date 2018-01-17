package js.npm;

import js.node.Buffer;

extern class Steno
implements npm.Package.Require<"steno","^0.4.1"> {
	@:overload(function(file : String, data : Buffer, cb : Null<Dynamic> -> Void) : Void {})
	public static function writeFile(file : String, data : String, cb : Null<Dynamic> -> Void) : Void;

	@:overload(function(file : String, data : Buffer) : Void {})
	public static function writeFileSync(file : String, data : String) : Void;
}
