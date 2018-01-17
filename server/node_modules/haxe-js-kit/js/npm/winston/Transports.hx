package js.npm.winston;

class Transports {}

@:native('transports.Console')
extern class Console
implements npm.Package.RequireNamespace<"winston", "^1.0.0">
{
	public static inline function construct(?options : {}) : Console {
		return untyped __new__( Console, options );
	}
}

@:native('transports.File')
extern class File
implements npm.Package.RequireNamespace<"winston", "^1.0.0">
{
	public static inline function construct(?options : {}) : File {
		return untyped __new__( File, options );
	}
}

@:native('transports.Memory')
extern class Memory
implements npm.Package.RequireNamespace<"winston", "^1.0.0">
{
	public static inline function construct(?options : {}) : Memory {
		return untyped __new__( Memory, options );
	}

	public var errorOutput : Array<String>;
	public var writeOutput : Array<String>;

	public function clearLogs() : Void;
}

extern class Loggly
implements npm.Package.RequireNamespace<"winston-loggly", "^1.0.0">
{
	public static inline function construct(?options : {}) : Loggly {
		return untyped __new__( Loggly, options );
	}
}

extern class Mail
implements npm.Package.RequireNamespace<"winston-mail", "^0.4.0">
{
	public static inline function construct(?options : {}) : Mail {
		return untyped __new__( Mail, options );
	}
}
