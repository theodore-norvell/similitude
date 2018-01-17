package js.npm;

extern class ObjectAssign
implements npm.Package.Require<"object-assign","2.0.0"> {
	public inline static function apply(a:Dynamic,b:Dynamic) : Dynamic {
		return untyped ObjectAssign(a,b);
	}
}