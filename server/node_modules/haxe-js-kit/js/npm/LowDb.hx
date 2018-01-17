package js.npm;

extern class LowDb implements Dynamic
implements npm.Package.RequireNamespace<"lowdb","^0.7.3"> {
	public static inline function construct(?fileName : String, ?options : {?autosave: Bool, ?async: Bool}) : LowDb {
		return untyped require('lowdb')(fileName, options);
	}

	public static inline function query(db : LowDb, collection : String) : LowDb {
		return untyped db(collection);
	}

	public static function mixin(obj : {}) : Void;
	
	public static var stringify : Dynamic -> String;
	public static var parse : String -> Dynamic;

	public var object : Dynamic;

	@:overload(function() : Void {})
	public function save(fileName : String) : Void;

	@:overload(function() : Void {})
	public function saveSync(fileName : String) : Void;
}
