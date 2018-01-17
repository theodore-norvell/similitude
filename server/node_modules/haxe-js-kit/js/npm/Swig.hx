package js.npm;

typedef SwigOptions = {
	? cache : Bool
}

extern class Swig
implements npm.Package.Require<"swig","*"> {
	public static function setDefaults(options : SwigOptions) : Void;
}