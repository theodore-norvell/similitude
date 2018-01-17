package js.npm;

@:native('Logger')
extern class Winston
implements npm.Package.RequireNamespace<"winston", "^1.0.0">
{
	public static var transports(default, default) : Dynamic;

	public static inline function construct(?options : {}) : Winston {
		return untyped __new__( Winston, options );
	}

	public var level(default, default) : String;

	@:overload(function(level : String, message : String) : Void {})
	@:overload(function(level : String, message : String, metadata : {}) : Void {})
	@:overload(function(level : String, message : String, fmt1 : Dynamic, metadata : {}) : Void {})
	public function log(level : String, message : String, fmt1 : Dynamic, fmt2 : Dynamic, metadata : {}) : Void;
}
